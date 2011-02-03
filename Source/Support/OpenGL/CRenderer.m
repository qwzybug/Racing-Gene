//
//  ES2Renderer.m
//  Racing Genes
//
//  Created by Jonathan Wight on 09/05/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import "CRenderer.h"

#import <QuartzCore/QuartzCore.h>

@interface CRenderer ()
@property (readwrite, nonatomic, assign) BOOL prepared;
@end

#pragma mark -

@implementation CRenderer

@synthesize prepareBlock;
@synthesize preRenderBlock;
@synthesize renderBlock;
@synthesize postRenderBlock;

@synthesize prepared;

- (id)init
    {
    if ((self = [super init]))
        {
        }

    return self;
    }

- (void)dealloc
    {
 	[preRenderBlock release];
	preRenderBlock = NULL;

    [renderBlock release];
    renderBlock = NULL;

    [postRenderBlock release];
    postRenderBlock = NULL;

    [super dealloc];
    }

#pragma mark -

- (void)render
    {
    if (self.prepared == NO && self.prepareBlock)
        {
        self.prepareBlock();

        self.prepared = YES;
        }
    
    if (self.preRenderBlock)
        {
        self.preRenderBlock();
        }

    if (self.renderBlock)
        {
        self.renderBlock();
        }

    if (self.postRenderBlock)
        {
        self.postRenderBlock();
        }

    }

@end
