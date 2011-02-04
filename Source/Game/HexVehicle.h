//
//  HexVehicle.h
//  Racing Gene
//
//  Created by Devin Chalmers on 2/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CSceneGraphNode;
@class CPhysicsBody;
@class HexCritter;

@interface HexVehicle : NSObject {

}

@property (readwrite, nonatomic, retain) CPhysicsBody *mainBody;
@property (readwrite, nonatomic, retain) CSceneGraphNode *geometry;

@property (readwrite, nonatomic, retain) HexCritter *critter;

@end
