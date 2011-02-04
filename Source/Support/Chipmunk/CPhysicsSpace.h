//
//  CPhysicsSpace.h
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "chipmunk.h"

@class CPhysicsBody;
@class CPhysicsShape;
@class CPhysicsConstraint;

@interface CPhysicsSpace : NSObject {

}

@property (readonly, nonatomic, assign) cpSpace *space;
@property (readonly, nonatomic, assign) CPhysicsBody *staticBody;

@property (readonly, nonatomic, assign) cpFloat simulationRate;
@property (readonly, nonatomic, assign) cpFloat simulationSteps;;

- (id)init;
- (id)initWithGravity:(cpVect)inGravity;

- (void)addBody:(CPhysicsBody *)inBody;
- (void)addShape:(CPhysicsShape *)inShape;
- (void)addStaticShape:(CPhysicsShape *)inShape;

- (void)addConstraint:(CPhysicsConstraint *)inConstraint;

- (void)step;

@end
