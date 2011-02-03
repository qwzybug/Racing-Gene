//
//  CHeightMap.h
//  Racing Genes
//
//  Created by Jonathan Wight on 09/07/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OpenGLIncludes.h"
#import "OpenGLTypes.h"

@class CVertexBuffer;
@class CMutableVertexBuffer;

typedef struct SHeightMapCell {
    Vector2 vector;
//    Color4 color;
    } SHeightMapCell;

@interface CHeightMap : NSObject {
    GLushort columns;
    GLushort rows;
    GLushort indexCount;
    CVertexBuffer *indexBuffer;
    GLushort vertexCount;
    CVertexBuffer *vertexBuffer;
    CMutableVertexBuffer *colorBuffer;
}

@property (readonly, nonatomic, assign) GLushort columns;
@property (readonly, nonatomic, assign) GLushort rows;
@property (readonly, nonatomic, assign) GLushort indexCount;
@property (readonly, nonatomic, retain) CVertexBuffer *indexBuffer;
@property (readonly, nonatomic, assign) GLushort vertexCount;
@property (readonly, nonatomic, retain) CVertexBuffer *vertexBuffer;
@property (readonly, nonatomic, retain) CMutableVertexBuffer *colorBuffer;

- (id)initWithColumns:(GLushort)inColumns rows:(GLushort)inRows;

@end
