//
//  EAGLView.h
//  Racing Genes
//
//  Created by Jonathan Wight on 09/05/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import <AppKit/AppKit.h>

#import <CoreVideo/CoreVideo.h>

#import "CRenderer.h"

//@class EAGLContext;
//@class CAEAGLLayer;

@interface CRendererView : NSOpenGLView {    
    NSInteger animationFrameInterval;
    CRenderer *renderer;
    BOOL animating;
    CVDisplayLinkRef displayLink;
//    EAGLContext *context;

    // The pixel dimensions of the CAEAGLLayer
    GLint backingWidth;
    GLint backingHeight;
    GLfloat aspectRatio;
}

@property (readwrite, nonatomic, assign) GLint backingWidth;
@property (readwrite, nonatomic, assign) GLint backingHeight;
@property (readwrite, nonatomic, assign) GLfloat aspectRatio;
//@property (readwrite, nonatomic, retain) EAGLContext *context;
@property (readwrite, nonatomic, assign) NSInteger animationFrameInterval;
@property (readwrite, nonatomic, retain) CRenderer *renderer;
@property (readonly, nonatomic, assign) BOOL animating;

- (void)startAnimation;
- (void)stopAnimation;

@end
