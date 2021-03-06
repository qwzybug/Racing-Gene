//
//  CPhysicsBody_Extensions.h
//  Racing Gene
//
//  Created by Jonathan Wight on 02/03/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CPhysicsBody.h"

@class CPhysicsShape;

@interface CPhysicsBody (CPhysicsBody_Extensions)

@property (readonly, nonatomic, retain) CPhysicsShape *shape;

- (CPhysicsBody *)addWheelAt:(cpVect)inPosition radius:(cpFloat)inRadius motorized:(BOOL)inMotorized rate:(cpFloat)inRate;

@end
