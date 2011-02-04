//
//  CGeometryNode.h
//  Racing Genes
//
//  Created by Jonathan Wight on 09/23/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import "CSceneNode.h"

#import "OpenGLIncludes.h"

@class CProgram;
@class CVertexBufferReference;
@class CTexture;

@interface CSceneGeometry : CSceneNode {
}

@property (readwrite, nonatomic, assign) GLenum type;
@property (readwrite, nonatomic, retain) CVertexBufferReference *indicesBufferReference;
@property (readwrite, nonatomic, retain) CVertexBufferReference *coordinatesBufferReference;
@property (readwrite, nonatomic, retain) CVertexBufferReference *textureCoordinatesBufferReference;
@property (readwrite, nonatomic, retain) CVertexBufferReference *colorsBufferReference;
@property (readwrite, nonatomic, retain) CTexture *texture;
@property (readwrite, nonatomic, retain) CProgram *program;
@property (readwrite, nonatomic, retain) NSSet *vertexBuffers;

@end
