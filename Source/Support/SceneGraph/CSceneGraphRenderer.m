//
//  CSceneGraphRenderer.m
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CSceneGraphRenderer.h"

#import "CSceneGraph.h"

@implementation CSceneGraphRenderer

@synthesize sceneGraph;
@synthesize transform;

- (id)init
    {
    if ((self = [super init]) != NULL)
        {
        __block __typeof__(self) _self = self;
        self.renderBlock = ^(void) {
            [_self.sceneGraph render:_self];
            };
            
        transform = Matrix4Identity;
        }
    return(self);
    }

- (id)initWithSceneGraph:(CSceneGraph *)inSceneGraph
	{
	if ((self = [self init]) != NULL)
		{
        sceneGraph = [inSceneGraph retain];
		}
	return(self);
	}

- (void)dealloc
    {
    [sceneGraph release];
    sceneGraph = NULL;
    //
    [super dealloc];
    }

@end
