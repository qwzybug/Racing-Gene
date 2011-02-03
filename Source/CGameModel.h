//
//  CTest.h
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CSceneGraph;
@class CChipmunkBody;

@interface CGameModel : NSObject {

}

@property (readwrite, nonatomic, retain) CSceneGraph *sceneGraph;
@property (readwrite, nonatomic, retain) CChipmunkBody *carBody;

- (void)update;

@end
