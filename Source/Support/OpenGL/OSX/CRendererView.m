//
//  EAGLView.m
//  Racing Genes
//
//  Created by Jonathan Wight on 09/05/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import "CRendererView.h"

#import "CRenderer.h"

// http://developer.apple.com/library/mac/#qa/qa2004/qa1385.html

static CVReturn MyDisplayLinkCallback(CVDisplayLinkRef displayLink, const CVTimeStamp* now, const CVTimeStamp* outputTime, CVOptionFlags flagsIn, CVOptionFlags* flagsOut, void* displayLinkContext);

@interface CRendererView ()
@property (readwrite, nonatomic, assign) BOOL animating;
@property (readwrite, nonatomic, assign) CVDisplayLinkRef displayLink;

//@property (readonly, nonatomic, retain) CAEAGLLayer *EAGLLayer;

- (void)setup;
@end

#pragma mark -

@implementation CRendererView

@synthesize backingWidth;
@synthesize backingHeight;
@synthesize aspectRatio;
@synthesize displayLink;
//@synthesize context;
@synthesize animationFrameInterval;
@synthesize renderer;
@synthesize animating;

- (id)initWithCoder:(NSCoder*)coder
    {    
    if ((self = [super initWithCoder:coder]))
        {
        [self setup];
        }

    return self;
    }

- (id)initWithFrame:(CGRect)inFrame;
    {    
    if ((self = [super initWithFrame:inFrame]))
        {
        [self setup];
        }

    return self;
    }
    
- (void)dealloc
    {
    [renderer release];
    renderer = NULL;

    [super dealloc];
    }

#pragma mark -

- (void)setup
    {
    NSLog(@"RENDER VIEW SETUP");
    
    // Get the layer
//    self.EAGLLayer.opaque = TRUE;
//    self.EAGLLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
//        [NSNumber numberWithBool:FALSE], kEAGLDrawablePropertyRetainedBacking,
//        kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat,
//        nil];

    [self.openGLContext makeCurrentContext];

    renderer = [[CRenderer alloc] init];

    animating = FALSE;
    animationFrameInterval = 2;
    displayLink = NULL;
    }

- (void)setAnimationFrameInterval:(NSInteger)frameInterval
    {
    // Frame interval defines how many display frames must pass between each time the display link fires. The display link will only fire 30 times a second when the frame internal is two on a display that refreshes 60 times a second. The default frame interval setting of one will fire 60 times a second when the display refreshes at 60 times a second. A frame interval setting of less than one results in undefined behavior.
    if (frameInterval >= 1)
        {
        animationFrameInterval = frameInterval;
        if (self.animating)
            {
            [self stopAnimation];
            [self startAnimation];
            }
        }
    }

- (void)startAnimation
    {
    if (!self.animating)
        {
        self.animating = TRUE;

        NSLog(@"START ANIMATION");

        CVDisplayLinkCreateWithActiveCGDisplays(&displayLink);
        CVDisplayLinkSetOutputCallback(self.displayLink, &MyDisplayLinkCallback, self);

        CGLContextObj theCGLContext = [[self openGLContext] CGLContextObj];
        CGLPixelFormatObj theCGLPixelFormat = [[self pixelFormat] CGLPixelFormatObj];
        CVDisplayLinkSetCurrentCGDisplayFromOpenGLContext(self.displayLink, theCGLContext, theCGLPixelFormat);

        // Activate the display link
        CVDisplayLinkStart(self.displayLink);
        }
    }

- (void)stopAnimation
    {
    if (self.animating)
        {
        self.animating = FALSE;

        NSLog(@"STOP ANIMATION");
        
//        [displayLink invalidate];
//        displayLink = nil;
        }
    }

- (void)drawRect:(NSRect)inRect
    {
    if (self.animating)
        {
        [self.openGLContext makeCurrentContext];

        glViewport(0, 0, 800, 600);

        glEnable(GL_BLEND);
        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

        glEnable(GL_DEPTH_TEST);
        
        glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
        glClearDepth(1.0f);
        glClear(GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT);

        [self.renderer render];

        glFlush();

        [self.openGLContext flushBuffer];
        }
    }

@end

static CVReturn MyDisplayLinkCallback(CVDisplayLinkRef displayLink, const CVTimeStamp* now, const CVTimeStamp* outputTime, CVOptionFlags flagsIn, CVOptionFlags* flagsOut, void* displayLinkContext)
    {
    NSAutoreleasePool *thePool = [[NSAutoreleasePool alloc] init];
    
    CRendererView *theRendererView = (CRendererView *)displayLinkContext;
    [theRendererView drawRect:theRendererView.bounds];
    
    [thePool drain];
    return(kCVReturnSuccess);
    }
