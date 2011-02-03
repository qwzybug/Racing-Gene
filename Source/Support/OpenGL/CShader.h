//
//  CShader.h
//  Racing Genes
//
//  Created by Jonathan Wight on 09/06/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OpenGLIncludes.h"

@interface CShader : NSObject {
    NSString *path;
    GLuint name;
}

@property (readonly, nonatomic, assign) GLuint name;

- (id)initWithPath:(NSString *)inPath;
- (id)initWithName:(NSString *)inName;

- (BOOL)compileShader:(NSError **)outError;

@end
