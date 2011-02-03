//
//  CVertexBuffer_FactoryExtensions.h
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CVertexBuffer.h"

@interface CVertexBuffer (CVertexBuffer_FactoryExtensions)

//+ (CVertexBuffer *)vertexBufferWithIndices:(NSArray *)inIndices;
+ (CVertexBuffer *)vertexBufferWithRect:(CGRect)inRect;
+ (CVertexBuffer *)vertexBufferWithColors:(NSArray *)inColors;
+ (CVertexBuffer *)vertexBufferWithCircleWithRadius:(GLfloat)inRadius points:(NSInteger)inPoints;

@end
