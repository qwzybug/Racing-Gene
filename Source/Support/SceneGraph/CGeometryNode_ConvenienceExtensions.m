//
//  CGeometryNode_ConvenienceExtensions.m
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CGeometryNode_ConvenienceExtensions.h"

#import "CProgram.h"
#import "CProgram_ConvenienceExtensions.h"
#import "CVertexBuffer.h"
#import "CVertexBuffer_FactoryExtensions.h"
#import "CVertexBufferReference.h"

@implementation CGeometryNode (CGeometryNode_ConvenienceExtensions)

+ (CGeometryNode *)flatGeometryNodeWithCoordinatesBuffer:(CVertexBuffer *)inVertexBuffer;
    {
    CProgram *theFlatProgram = [[[CProgram alloc] initWithFilename:@"Flat" attributeNames:[NSArray arrayWithObjects:@"vertex", @"color", @"texture", NULL] uniformNames:NULL] autorelease];

    CGeometryNode *theNode = [[[CGeometryNode alloc] init] autorelease];
    theNode.transform = Matrix4MakeScale(1, 1, 1);
    theNode.type = GL_LINE_STRIP;
    theNode.coordinatesBufferReference = [[[CVertexBufferReference alloc] initWithVertexBuffer:inVertexBuffer cellEncoding:@encode(Vector2) normalized:GL_FALSE stride:0] autorelease];
    theNode.program = theFlatProgram;
    theNode.vertexBuffers = [NSSet setWithObjects:inVertexBuffer, NULL];
    
    return(theNode);
    }

+ (CGeometryNode *)circleGeometryNodeWithRadius:(GLfloat)inRadius;
    {
    CProgram *theFlatProgram = [[[CProgram alloc] initWithFilename:@"Flat" attributeNames:[NSArray arrayWithObjects:@"vertex", @"color", @"texture", NULL] uniformNames:NULL] autorelease];

    CVertexBuffer *theBallCoordinates = [CVertexBuffer vertexBufferWithCircleWithRadius:inRadius points:30];

    CGeometryNode *theBallNode = [[[CGeometryNode alloc] init] autorelease];
    theBallNode.transform = Matrix4MakeScale(1, 1, 1);
    theBallNode.type = GL_LINE_STRIP;
    theBallNode.coordinatesBufferReference = [[[CVertexBufferReference alloc] initWithVertexBuffer:theBallCoordinates cellEncoding:@encode(Vector2) normalized:GL_FALSE stride:0] autorelease];
    theBallNode.program = theFlatProgram;
    theBallNode.vertexBuffers = [NSSet setWithObjects:theBallCoordinates, NULL];
    
    return(theBallNode);
    }
    
@end
