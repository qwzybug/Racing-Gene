//
//  CSceneGraphRenderer.h
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CRenderer.h"

#import "OpenGLTypes.h"

@class CSceneGraph;

@interface CSceneGraphRenderer : CRenderer {
}

@property (readwrite, nonatomic, retain) CSceneGraph *sceneGraph;

@property (readwrite, nonatomic, assign) Matrix4 transform;;

- (id)initWithSceneGraph:(CSceneGraph *)inSceneGraph;

@end
