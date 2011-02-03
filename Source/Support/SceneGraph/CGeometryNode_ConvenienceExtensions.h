//
//  CGeometryNode_ConvenienceExtensions.h
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CGeometryNode.h"

@class CVertexBuffer;

@interface CGeometryNode (CGeometryNode_ConvenienceExtensions)

+ (CGeometryNode *)flatGeometryNodeWithCoordinatesBuffer:(CVertexBuffer *)inVertexBuffer;
+ (CGeometryNode *)circleGeometryNodeWithRadius:(GLfloat)inRadius;

@end
