//
//  ES2Renderer.h
//  Racing Genes
//
//  Created by Jonathan Wight on 09/05/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OpenGLIncludes.h"

@interface CRenderer : NSObject {
    }

@property (readwrite, nonatomic, copy) void (^prepareBlock)(void);
@property (readwrite, nonatomic, copy) void (^preRenderBlock)(void);
@property (readwrite, nonatomic, copy) void (^renderBlock)(void);
@property (readwrite, nonatomic, copy) void (^postRenderBlock)(void);

- (void)render;

@end

