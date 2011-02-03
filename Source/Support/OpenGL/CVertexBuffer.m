//
//  CVertexArray.m
//  Racing Genes
//
//  Created by Jonathan Wight on 09/05/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import "CVertexBuffer.h"

#import "OpenGLTypes.h"
#import "CVertexBufferReference.h"

@implementation CVertexBuffer

@synthesize target;
@synthesize usage;
@synthesize data;
@synthesize name;
@synthesize references;

- (id)initWithTarget:(GLenum)inTarget usage:(GLenum)inUsage data:(NSData *)inData;
    {
    if ((self = [super init]) != NULL)
        {
        target = inTarget;
        usage = inUsage;
        data = [inData retain];
        references = [NSArray array];
        }
    return(self);
    }
    
- (id)initWithTarget:(GLenum)inTarget usage:(GLenum)inUsage bytes:(void *)inBytes length:(size_t)inLength;
    {
    if ((self = [self initWithTarget:inTarget usage:inUsage data:[NSData dataWithBytes:inBytes length:inLength]]) != NULL)
        {
        }
    return(self);
    }
    
- (void)dealloc
    {
    if (name != 0)
        {
        glDeleteBuffers(1, &name);
        name = 0;
        }
    
    [data release];
    data = NULL;
    //
    for (CVertexBufferReference *theReference in references)
        {
        [theReference bufferInvalidated];
        }
    [references release];
    references = NULL;
    //
    [super dealloc];
    }
    
- (NSString *)description
    {
    return([NSString stringWithFormat:@"%@ (target: 0x%X, usage: 0x%X, data: %d bytes @ %p, name: %d, references:%d)", [super description], self.target, self.usage, self.data.length, self.data.bytes, self.name, self.references.count]);
    }

- (GLuint)name
    {
    if (name == 0)
        {
        AssertOpenGLNoError_();
        
        GLuint theName;
        glGenBuffers(1, &theName);
        glBindBuffer(self.target, theName);
        glBufferData(self.target, [self.data length], NULL, self.usage);
        glBufferSubData(self.target, 0, [self.data length], [self.data bytes]);

        AssertOpenGLNoError_();
        
        GLenum theError = glGetError();
        if (theError != GL_NO_ERROR)
            {
            NSLog(@"Vertex Buffer Error: %x", theError);
            NSAssert(NO, @"Vertex Buffer Error");
            }

        // TODO: either skip this - or save/restore previous value
        glBindBuffer(GL_ARRAY_BUFFER, 0);
        
        name = theName;
//        
//        [data release];
//        data = NULL;
        AssertOpenGLNoError_();
        }
    return(name);
    }

@end
