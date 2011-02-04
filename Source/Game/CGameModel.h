//
//  CGameModel.h
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CScene;
@class CPhysicsBody;
@class CVehicle;

@interface CGameModel : NSObject {

}

@property (readwrite, nonatomic, retain) CScene *sceneGraph;
@property (readwrite, nonatomic, retain) CPhysicsBody *carBody;
@property (readwrite, nonatomic, retain) CVehicle *vehicle;


- (void)update;

@end
