//
//  CVertexBuffer_FactoryExtensions.m
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CVertexBuffer_FactoryExtensions.h"

#import "OpenGLTypes.h"

@implementation CVertexBuffer (CVertexBuffer_FactoryExtensions)

//+ (CVertexBuffer *)vertexBufferWithIndices:(NSArray *)inIndices;
//    {
//    GLint 
//    
//    
//    }

+ (CVertexBuffer *)vertexBufferWithRect:(CGRect)inRect
    {
    const Vector2 theVertices[] = {
        { CGRectGetMinX(inRect), CGRectGetMinY(inRect) },
        { CGRectGetMaxX(inRect), CGRectGetMinY(inRect) },
        { CGRectGetMinX(inRect), CGRectGetMaxY(inRect) },
        { CGRectGetMaxX(inRect), CGRectGetMaxY(inRect) },
        };

    NSData *theData = [NSData dataWithBytes:theVertices length:sizeof(theVertices)];
    CVertexBuffer *theVertexBuffer = [[[CVertexBuffer alloc] initWithTarget:GL_ARRAY_BUFFER usage:GL_STATIC_DRAW data:theData] autorelease];
    
    return(theVertexBuffer);
    }
    
+ (CVertexBuffer *)vertexBufferWithColors:(NSArray *)inColors;
    {
    NSMutableData *theData = [NSMutableData dataWithLength:sizeof(Color4) * [inColors count]];
    
    Color4 *V = theData.mutableBytes;
    
    for (NSColor *theColor in inColors)
        {
        theColor = [theColor colorUsingColorSpaceName:NSDeviceRGBColorSpace];
        *V++ = (Color4){ theColor.redComponent * 255.0, theColor.greenComponent * 255.0, theColor.blueComponent * 255.0, theColor.alphaComponent * 255.0 };
        }
    
    CVertexBuffer *theVertexBuffer = [[[CVertexBuffer alloc] initWithTarget:GL_ARRAY_BUFFER usage:GL_STATIC_DRAW data:theData] autorelease];
    return(theVertexBuffer);
    }

+ (CVertexBuffer *)vertexBufferWithCircleWithRadius:(GLfloat)inRadius points:(NSInteger)inPoints
    {
    NSMutableData *theData = [NSMutableData dataWithLength:sizeof(Vector2) * (inPoints + 2)];

    Vector2 *V = theData.mutableBytes;
    
    *V++ = (Vector2){ 0.0, 0.0 };

    for (NSInteger N = 0; N != inPoints + 1; ++N)
        {
        double theta = (double)N / (double)inPoints * 2 * M_PI;
        
        *V++ = (Vector2){ cos(theta) * inRadius, sin(theta) * inRadius };
        }

    CVertexBuffer *theVertexBuffer = [[[CVertexBuffer alloc] initWithTarget:GL_ARRAY_BUFFER usage:GL_STATIC_DRAW data:theData] autorelease];
    
    return(theVertexBuffer);
    }


@end
