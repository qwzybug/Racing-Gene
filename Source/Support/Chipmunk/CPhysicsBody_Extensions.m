//
//  CPhysicsBody_Extensions.m
//  Racing Gene
//
//  Created by Jonathan Wight on 02/03/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CPhysicsBody_Extensions.h"

#import "CPhysicsShape.h"
#import "CPhysicsConstraint.h"

@implementation CPhysicsBody (CPhysicsBody_Extensions)

- (CPhysicsShape *)shape
    {
    NSAssert(self.shapes.count == 1, @"Expected just 1 shape");
    return([self.shapes lastObject]);
    }

- (CPhysicsBody *)addWheelAt:(cpVect)inPosition radius:(cpFloat)inRadius motorized:(BOOL)inMotorized rate:(cpFloat)inRate;
    {
    CPhysicsBody *theWheelBody = [[[CPhysicsBody alloc] initWithMass:100 inertia:100] autorelease];
    theWheelBody.position = inPosition;

    CPhysicsShape *theWheelShape = [CPhysicsShape ballShapeWithBody:theWheelBody radius:inRadius];
    theWheelShape.group = 1;
    theWheelShape.elasticity = 1.4;
    theWheelShape.friction = 10.0;
    [theWheelBody addShape:theWheelShape];

    CPhysicsConstraint *thePivot = [[[CPhysicsConstraint alloc] initWithConstraint:cpPivotJointNew2(self.body, theWheelBody.body, inPosition, (cpVect){ 0, 0 })] autorelease];
    [self addConstraint:thePivot];

    if (inMotorized)
        {
        CPhysicsConstraint *theMotor = [[[CPhysicsConstraint alloc] initWithConstraint:cpSimpleMotorNew(theWheelBody.body, self.body, inRate)] autorelease];
        [self addConstraint:theMotor];
        }

    [self addSubbody:theWheelBody];
    }

@end
