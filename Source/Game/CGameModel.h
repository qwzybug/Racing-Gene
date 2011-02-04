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
@class HexVehicle;

@interface CGameModel : NSObject {

}

@property (readwrite, nonatomic, retain) CScene *sceneGraph;
@property (readwrite, nonatomic, retain) HexVehicle *vehicle;


- (void)update;

@end
