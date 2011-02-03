//
//  CProgram.m
//  Racing Genes
//
//  Created by Jonathan Wight on 09/05/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import "CProgram.h"

#import "OpenGLTypes.h"
#import "CShader.h"

@interface CProgram ()
@property (readwrite, nonatomic, copy) NSArray *shaders;    
@property (readonly, nonatomic, copy) NSMutableDictionary *attributesByName;    
@property (readonly, nonatomic, copy) NSMutableDictionary *uniformsByName;
@property (readwrite, nonatomic, assign) GLuint name;
@end

#pragma mark -

@implementation CProgram

@synthesize shaders;
@synthesize attributesByName;
@synthesize uniformsByName;
@synthesize name;

- (id)initWithFiles:(NSArray *)inShaders
    {
    if ((self = [super init]) != NULL)
        {
        shaders = [inShaders copy];
        attributesByName = [[NSMutableDictionary alloc] init];
        uniformsByName = [[NSMutableDictionary alloc] init];
        name = 0;
        }
    return(self);
    }

- (id)initWithFiles:(NSArray *)inShaders attributeNames:(NSArray *)inAttributeNames uniformNames:(NSArray *)inUniformNames
    {
    if ((self = [self initWithFiles:inShaders]) != NULL)
        {
        GLuint theAttributeIndex = 0;
        NSMutableDictionary *theAttributesByName = [NSMutableDictionary dictionary];
        for (NSString *theAttributeName in inAttributeNames)
            {
            [theAttributesByName setObject:[NSNumber numberWithUnsignedInt:theAttributeIndex++] forKey:theAttributeName];
            }
        attributesByName = [theAttributesByName copy];
        }
    return(self);
    }

- (void)dealloc
    {
    [shaders release];
    shaders = NULL;
    
    [attributesByName release];
    attributesByName = NULL;
    
    [uniformsByName release];
    uniformsByName = NULL;
    
    if (name)
        {
        glDeleteProgram(name);
        name = 0;
        }
        
    [super dealloc];
    }

#pragma mark -

- (GLuint)name
    {
    if (name == 0)
        {
        [self linkProgram:NULL];
        }
    return(name);
    }
    
//- (NSMutableDictionary *)uniformsByName
//    {
//    if (uniformsByName == NULL)
//        {
//        NSMutableDictionary *theUniformsByName = [NSMutableDictionary dictionary];
//        for (NSString *theUniformName in self.uniforms)
//            {
//            GLuint theLocation = glGetUniformLocation(self.name, [theUniformName UTF8String]);
//            [theUniformsByName setObject:[NSNumber numberWithUnsignedInt:theLocation] forKey:theUniformName];
//            }
//        uniformsByName = [theUniformsByName retain];
//        }
//    return(uniformsByName);
//    }

#pragma mark -

- (BOOL)linkProgram:(NSError **)outError
    {
    AssertOpenGLNoError_();

    // Create shader program
    GLuint theProgramName = glCreateProgram();

    AssertOpenGLNoError_();
    
    // Attach shaders to program...
    for (CShader *theShader in self.shaders)
        {
        AssertOpenGLNoError_();
        NSAssert(theShader.name != 0, @"No shader name");
        glAttachShader(theProgramName, theShader.name);
        AssertOpenGLNoError_();
        }

    AssertOpenGLNoError_();

    // Bind attribute locations this needs to be done prior to linking
    for (NSString *theAttributeName in self.attributesByName)
        {
        GLuint theAttributeIndex = [[self.attributesByName objectForKey:theAttributeName] unsignedIntValue];
        glBindAttribLocation(theProgramName, theAttributeIndex, [theAttributeName UTF8String]);
        }

    AssertOpenGLNoError_();

    // Link program
    glLinkProgram(theProgramName);

    GLint theStatus = GL_FALSE;
    glGetProgramiv(theProgramName, GL_LINK_STATUS, &theStatus);
    if (theStatus == GL_FALSE)
        {
        NSMutableDictionary *theUserInfo = [NSMutableDictionary dictionary];
        GLint theLogLength;
        glGetProgramiv(theProgramName, GL_INFO_LOG_LENGTH, &theLogLength);
        if (theLogLength > 0)
            {
            GLchar *theLogStringBuffer = (GLchar *)malloc(theLogLength);
            glGetProgramInfoLog(theProgramName, theLogLength, &theLogLength, theLogStringBuffer);
            [theUserInfo setObject:[NSString stringWithUTF8String:theLogStringBuffer] forKey:NSLocalizedDescriptionKey];
            free(theLogStringBuffer);
            }
        if (outError)
            {
            *outError = [NSError errorWithDomain:@"OpenGL" code:-1 userInfo:theUserInfo];
            }
        return(NO);
        }

    AssertOpenGLNoError_();
    
    name = theProgramName;

    self.shaders = NULL;

    AssertOpenGLNoError_();

    return(YES);
    }

- (BOOL)validate:(NSError **)outError
    {
    glValidateProgram(self.name);

    GLint theStatus = GL_FALSE;
    glGetProgramiv(self.name, GL_VALIDATE_STATUS, &theStatus);
    if (theStatus == GL_TRUE)
        {
        return(YES);
        }
    else
        {
        if (outError)
            {
            NSMutableDictionary *theUserInfo = [NSMutableDictionary dictionary];
            GLint theLogLength;
            glGetProgramiv(self.name, GL_INFO_LOG_LENGTH, &theLogLength);
            if (theLogLength > 0)
                {
                GLchar *theLogStringBuffer = (GLchar *)malloc(theLogLength);
                glGetProgramInfoLog(self.name, theLogLength, &theLogLength, theLogStringBuffer);
                [theUserInfo setObject:[NSString stringWithUTF8String:theLogStringBuffer] forKey:NSLocalizedDescriptionKey];
                free(theLogStringBuffer);
                }
            *outError = [NSError errorWithDomain:@"OpenGL" code:-1 userInfo:theUserInfo];
            }
        return(NO);
        }
    }
    
- (GLuint)attributeIndexForName:(NSString *)inName
    {
    NSNumber *theNumber = [self.attributesByName objectForKey:inName];
    if (theNumber == NULL)
        {
        GLuint theIndex = self.attributesByName.count;
        theNumber = [NSNumber numberWithUnsignedInt:theIndex];
        [self.attributesByName setObject:theNumber forKey:inName];
        return(theIndex);
        }
    else
        {
        return([theNumber unsignedIntValue]);
        }
    }
    
- (GLuint)uniformIndexForName:(NSString *)inName
    {
    if ([self.uniformsByName objectForKey:inName] == NULL)
        {
        AssertOpenGLNoError_();
        GLint theLocation = glGetUniformLocation(self.name, [inName UTF8String]);
        if (theLocation == -1)
            {
            NSAssert1(NO, @"Could not get uniform location for: %@", inName);
            }
        
        NSLog(@"%x %x", theLocation, GL_INVALID_VALUE);
        
        AssertOpenGLNoError_();
        [self.uniformsByName setObject:[NSNumber numberWithInt:theLocation] forKey:inName];
        return(theLocation);
        }
    else
        {
        return([[self.uniformsByName objectForKey:inName] unsignedIntValue]);
        }
    }


@end
