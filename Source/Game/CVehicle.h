//
//  CCar.h
//  Racing Gene
//
//  Created by Jonathan Wight on 02/03/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CSceneGraphNode;
@class CPhysicsBody;

@interface CVehicle : NSObject {

}

@property (readwrite, nonatomic, retain) CPhysicsBody *chassis;
@property (readwrite, nonatomic, retain) CPhysicsBody *rearWheel;
@property (readwrite, nonatomic, retain) CPhysicsBody *frontWheel;
@property (readwrite, nonatomic, retain) CSceneGraphNode *geometry;

@end
