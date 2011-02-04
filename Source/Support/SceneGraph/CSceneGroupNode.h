//
//  CGroupNode.h
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CSceneNode.h"


@interface CSceneGroupNode : CSceneNode {

}

@property (readwrite, nonatomic, retain) NSArray *nodes;

@end
