//
//  CRendererOpenGLLayer.m
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CRendererOpenGLLayer.h"

#import "CRenderer.h"

@interface CRendererOpenGLLayer ()
@end

#pragma mark -

@implementation CRendererOpenGLLayer

@synthesize renderer;

- (id)init
    {
    if ((self = [super init]) != NULL)
        {
        self.asynchronous = YES;
        }
    return(self);
    }

- (void)dealloc
    {
    [renderer release];
    renderer = NULL;
    //
    [super dealloc];
    }


- (void)drawInCGLContext:(CGLContextObj)ctx pixelFormat:(CGLPixelFormatObj)pf forLayerTime:(CFTimeInterval)t displayTime:(const CVTimeStamp *)ts
    {
    CGLSetCurrentContext(ctx);
    
//    CGRect theBounds = self.bounds;
//    glViewport(0, 0, theBounds.size.width, theBounds.size.height);

    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

    glEnable(GL_DEPTH_TEST);
    
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    glClearDepth(1.0f);
    glClear(GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT);

    [self.renderer render];

//    glFlush();
    
    [super drawInCGLContext:ctx pixelFormat:pf forLayerTime:t displayTime:ts];
    }


@end
