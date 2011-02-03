//
//  CTestRenderer.m
//  Racing Gene
//
//  Created by Jonathan Wight on 01/22/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CTestRenderer.h"

#import "OpenGLTypes.h"
#import "CProgram.h"
#import "CShader.h"
#import "CVertexBuffer.h"
#import "CImageTextureLoader.h"
#import "CTexture.h"

@interface CTestRenderer ()
@property (readwrite, nonatomic, assign) BOOL setupDone;

- (void)setup;
@end

#pragma mark -

@implementation CTestRenderer

@synthesize setupDone;

- (id)init
    {
    if ((self = [super init]) != NULL)
        {
        }
    return(self);
    }
    
- (void)render
    {
    if (self.setupDone == NO)
        {
        [self setup];
        self.setupDone = YES;
        }
        
    [super render];
    }

- (void)setup
    {
    NSArray *theShaders = [NSArray arrayWithObjects:   
        [[[CShader alloc] initWithName:@"Shader.fsh"] autorelease],
        [[[CShader alloc] initWithName:@"Shader.vsh"] autorelease],
        NULL];
    
    CProgram *theProgram = [[[CProgram alloc] initWithFiles:theShaders] autorelease];

    // Geometry Vertices
    const GLfloat squareVertices[] = {
        -1.0f, -1.0f,
         1.0f, -1.0f,
        -1.0f,  1.0f,
         1.0f,  1.0f,
        };
    CVertexBuffer *theVertices = [[[CVertexBuffer alloc] initWithTarget:GL_ARRAY_BUFFER usage:GL_STATIC_DRAW data:[NSData dataWithBytes:squareVertices length:sizeof(squareVertices)]] autorelease];

    const GLfloat theTextureVertices[] = {
        0.0f, 1.0f,
        1.0f, 1.0f,
        0.0f, 0.0f,
        1.0f, 0.0f,
        };
    CVertexBuffer *theTextureVertexBuffer = [[[CVertexBuffer alloc] initWithTarget:GL_ARRAY_BUFFER usage:GL_STATIC_DRAW data:[NSData dataWithBytes:theTextureVertices length:sizeof(theTextureVertices)]] autorelease];

    // Colors
    const GLubyte squareColors[] = {
        255, 255, 255, 255,
        255, 0, 255, 255,
        255, 255, 255, 255,
        255, 255, 255, 255,
        };

    CVertexBuffer *theColors = [[[CVertexBuffer alloc] initWithTarget:GL_ARRAY_BUFFER usage:GL_STATIC_DRAW data:[NSData dataWithBytes:squareColors length:sizeof(squareColors)]] autorelease];;

    CImageTextureLoader *theLoader = [[[CImageTextureLoader alloc] init] autorelease];
    CTexture *theTexture = [theLoader textureWithImage:[NSImage imageNamed:@"Brick"] error:NULL];

    GLuint theVertexAttributeIndex = [theProgram attributeIndexForName:@"vertex"];
    GLuint theColorAttributeIndex = [theProgram attributeIndexForName:@"color"];
    GLuint theTextureAttributeIndex = [theProgram attributeIndexForName:@"texture"];
    GLuint theTranslateUniformIndex = [theProgram uniformIndexForName:@"translate"];
    static CGFloat transY = 0.0f;
    
    self.renderBlock = ^(void) {

        AssertOpenGLNoError_();

        // Use shader program
        glUseProgram(theProgram.name);

        // Update uniform value
        glUniform1f(theTranslateUniformIndex, transY);
        transY = 1.0f;	

        // Update attribute values
        glBindBuffer(GL_ARRAY_BUFFER, theVertices.name);
        glVertexAttribPointer(theVertexAttributeIndex, 2, GL_FLOAT, GL_FALSE, 0, 0);
        glEnableVertexAttribArray(theVertexAttributeIndex);

        glBindBuffer(GL_ARRAY_BUFFER, theColors.name);
        glVertexAttribPointer(theColorAttributeIndex, 4, GL_UNSIGNED_BYTE, GL_TRUE, 0, 0);
        glEnableVertexAttribArray(theColorAttributeIndex);

        glBindBuffer(GL_ARRAY_BUFFER, theTextureVertexBuffer.name);
        glVertexAttribPointer(theTextureAttributeIndex, 2, GL_FLOAT, GL_FALSE, 0, 0);
        glEnableVertexAttribArray(theTextureAttributeIndex);

        glBindTexture(GL_TEXTURE_2D, theTexture.name);

        // Validate program before drawing. This is a good check, but only really necessary in a debug build. DEBUG macro must be defined in your debug configurations if that's not already the case.
    #if defined(DEBUG)
        NSError *theError = NULL;
        if ([theProgram validate:&theError] == NO)
            {
            NSLog(@"Failed to validate program: %@", theError);
            return;
            }
    #endif

        // Draw
        glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
        };
    }

@end
