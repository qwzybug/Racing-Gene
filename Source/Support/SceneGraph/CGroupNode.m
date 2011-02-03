//
//  CGroupNode.m
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CGroupNode.h"

#import "CSceneGraphNode.h"

@implementation CGroupNode

@synthesize nodes;

- (void)dealloc
    {
    [nodes release];
    nodes = NULL;
    //
    [super dealloc];
    }

- (void)render:(CSceneGraphRenderer *)inRenderer
    {
    for (CSceneGraphNode *theNode in self.nodes)
        {
        [theNode render:inRenderer];
        }
    }

@end
