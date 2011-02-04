//
//  CSceneGraphNode.h
//  Racing Genes
//
//  Created by Jonathan Wight on 09/23/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OpenGLTypes.h"

@class CSceneGraphRenderer;

@interface CSceneNode : NSObject {
}

@property (readwrite, nonatomic, assign) Matrix4 transform;

- (void)prerender:(CSceneGraphRenderer *)inRenderer;
- (void)render:(CSceneGraphRenderer *)inRenderer;
- (void)postRender:(CSceneGraphRenderer *)inRenderer;

@end
