//
//  CRendererView2.m
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CRendererView2.h"

#import "CRendererOpenGLLayer.h"

@interface CRendererView2 ()
- (void)setup;
@end

#pragma mark -

@implementation CRendererView2

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
    [super dealloc];
    }

#pragma mark -

- (void)setup
    {
    self.layer = [[[CRendererOpenGLLayer alloc] init] autorelease];
    }

#pragma mark -

- (CRendererOpenGLLayer *)rendererLayer
    {
    return((CRendererOpenGLLayer *)self.layer);
    }

@end
