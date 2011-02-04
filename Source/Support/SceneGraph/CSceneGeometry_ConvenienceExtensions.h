//
//  CSceneGeometry_ConvenienceExtensions.h
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CSceneGeometry.h"

@class CVertexBuffer;

@interface CSceneGeometry (CSceneGeometry_ConvenienceExtensions)

+ (CSceneGeometry *)flatGeometryNodeWithCoordinatesBuffer:(CVertexBuffer *)inVertexBuffer;
+ (CSceneGeometry *)circleGeometryNodeWithRadius:(GLfloat)inRadius;

@end
