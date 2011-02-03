//
//  CSceneGraphNode.m
//  Racing Genes
//
//  Created by Jonathan Wight on 09/23/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import "CSceneGraphNode.h"

#import "CSceneGraphNode.h"
#import "CGeometryNode.h"

@implementation CSceneGraphNode

@synthesize transform;

- (id)init
	{
	if ((self = [super init]) != NULL)
		{
        transform = Matrix4Identity;
		}
	return(self);
	}

- (void)prerender:(CSceneGraphRenderer *)inRenderer
    {
    }

- (void)render:(CSceneGraphRenderer *)inRenderer;
    {
    }

- (void)postRender:(CSceneGraphRenderer *)inRenderer;
    {
    }

@end
