//
//  CTexture.h
//  Racing Genes
//
//  Created by Jonathan Wight on 09/06/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OpenGLIncludes.h"

@interface CTexture : NSObject {
    GLuint name;
	GLuint width;
    GLuint height;
	GLenum internalFormat;
	GLboolean hasAlpha;
}

@property (readonly, nonatomic, assign) GLuint name;
@property (readonly, nonatomic, assign) GLuint width;
@property (readonly, nonatomic, assign) GLuint height;
@property (readonly, nonatomic, assign) GLenum internalFormat;
@property (readonly, nonatomic, assign) GLboolean hasAlpha;

- (id)initWithName:(GLuint)inName width:(GLuint)inWidth height:(GLuint)inHeight;

@end
