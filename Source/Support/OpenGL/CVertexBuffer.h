//
//  CVertexArray.h
//  Racing Genes
//
//  Created by Jonathan Wight on 09/05/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OpenGLIncludes.h"

@interface CVertexBuffer : NSObject {
}

@property (readonly, nonatomic, assign) GLenum target; // GL_ARRAY_BUFFER or GL_ELEMENT_ARRAY_BUFFER
@property (readonly, nonatomic, assign) GLenum usage; // GL_STREAM_DRAW, GL_STATIC_DRAW, GL_DYNAMIC_DRAW
@property (readonly, nonatomic, retain) NSData *data;
@property (readonly, nonatomic, assign) GLuint name;
@property (readwrite, nonatomic, assign) NSArray *references;

- (id)initWithTarget:(GLenum)inTarget usage:(GLenum)inUsage data:(NSData *)inData;
- (id)initWithTarget:(GLenum)inTarget usage:(GLenum)inUsage bytes:(void *)inBytes length:(size_t)inLength;

@end
