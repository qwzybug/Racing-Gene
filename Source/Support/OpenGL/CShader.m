//
//  CShader.m
//  Racing Genes
//
//  Created by Jonathan Wight on 09/06/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import "CShader.h"

#import "OpenGLTypes.h"

@interface CShader ()
@property (readwrite, nonatomic, retain) NSString *path;
@property (readwrite, nonatomic, assign) GLuint name;
@end

#pragma mark -

@implementation CShader

@synthesize path;
@synthesize name;

- (id)initWithPath:(NSString *)inPath
    {
    if ((self = [super init]) != NULL)
        {
        path = [inPath retain];
        }
    return(self);
    }

- (id)initWithName:(NSString *)inName
    {
    NSString *thePath = [[NSBundle mainBundle] pathForResource:[inName stringByDeletingPathExtension] ofType:[inName pathExtension]];
    NSAssert(thePath, @"Nothing at path.");
    

    if ((self = [self initWithPath:thePath]) != NULL)
        {
        }
    return(self);
    }

- (void)dealloc
    {
    [path release];
    path = NULL;

    if (name)
        {
        glDeleteShader(name);
        name = 0;
        }
    //
    [super dealloc];
    }

- (GLuint)name
    {
    if (name == 0)
        {
        [self compileShader:NULL];
        }
    return(name);
    }


- (BOOL)compileShader:(NSError **)outError
    {
    AssertOpenGLNoError_();
    
    GLint theStatus;
    const GLchar *theSource;

    theSource = (GLchar *)[[NSString stringWithContentsOfFile:self.path encoding:NSUTF8StringEncoding error:nil] UTF8String];
    if (!theSource)
        {
        NSLog(@"Failed to load vertex shader");
        return FALSE;
        }

    AssertOpenGLNoError_();
        
    GLenum theType = 0;
    if ([[self.path pathExtension] isEqualToString:@"fsh"])
        {
        theType = GL_FRAGMENT_SHADER;
        }
    else if ([[self.path pathExtension] isEqualToString:@"vsh"])
        {
        theType = GL_VERTEX_SHADER;
        }
    else
        {
        return(NO);
        }

    AssertOpenGLNoError_();

    GLuint theName = glCreateShader(theType);
    glShaderSource(theName, 1, &theSource, NULL);
    glCompileShader(theName);

    AssertOpenGLNoError_();

#if defined(DEBUG)
    GLint logLength;
    glGetShaderiv(theName, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
        {
        GLchar *theLogBuffer = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(theName, logLength, &logLength, theLogBuffer);
        NSLog(@"Shader compile log:\n%s", theLogBuffer);
        free(theLogBuffer);
        }
#endif

    AssertOpenGLNoError_();

    glGetShaderiv(theName, GL_COMPILE_STATUS, &theStatus);
    if (theStatus == 0)
        {
        glDeleteShader(theName);
        return FALSE;
        }

    AssertOpenGLNoError_();

    name = theName;

    return(TRUE);
    }



@end
