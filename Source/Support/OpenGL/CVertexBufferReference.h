//
//  CVertexBufferReference.h
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OpenGLIncludes.h"

@class CVertexBuffer;

@interface CVertexBufferReference : NSObject {
}

@property (readonly, nonatomic, assign) CVertexBuffer *vertexBuffer;

@property (readonly, nonatomic, assign) const char *cellEncoding;
@property (readonly, nonatomic, assign) GLint cellSize;
@property (readonly, nonatomic, assign) GLint cellCount;

@property (readonly, nonatomic, assign) GLint size;
@property (readonly, nonatomic, assign) GLenum type;
@property (readonly, nonatomic, assign) GLboolean normalized;
@property (readonly, nonatomic, assign) GLsizei stride;

- (id)initWithVertexBuffer:(CVertexBuffer *)inVertexBuffer cellEncoding:(char *)inEncoding normalized:(GLboolean)inNormalized stride:(GLsizei)inStride;

- (void)bufferUpdated;
- (void)bufferInvalidated;

@end
