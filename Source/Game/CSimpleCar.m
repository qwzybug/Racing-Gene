//
//  CCar.m
//  Racing Gene
//
//  Created by Jonathan Wight on 02/03/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CSimpleCar.h"

#include "chipmunk.h"

#import "CPhysicsBody.h"
#import "CSceneGeometry.h"
#import "CSceneGroup.h"
#import "CPhysicsShape.h"
#import "CSceneGeometry.h"
#import "CPhysicsBody_Extensions.h"
#import "CPhysicsShape_GeometryExtensions.h"
#import "CSceneGeometry_ConvenienceExtensions.h"
#import "CPhysicsConstraint.h"
#import "CPhysicsBody_GeometryExtensions.h"

@interface CSimpleCar ()
- (void)setup;
@end

@implementation CSimpleCar

@synthesize rearWheel;
@synthesize frontWheel;

- (id)init
    {
    if ((self = [super init]) != NULL)
        {
        [self setup];
        }
    return(self);
    }

- (void)setup
    {
    CGFloat carY = 100;

    // #################################################################

    self.chassis = [[[CPhysicsBody alloc] initWithMass:100 inertia:100] autorelease];
    self.chassis.position = (cpVect){ 0, 50 };

    CPhysicsShape *theBodyShape = [CPhysicsShape boxShapeWithBody:self.chassis size:(CGSize){ 100, 5 }];
    theBodyShape.group = 1;
    theBodyShape.elasticity = 1.4;
    theBodyShape.friction = 0.5;
    [self.chassis addShape:theBodyShape];

    // #################################################################

    CGFloat tireRadius = 40.0;
    CGFloat kWheelRate = -10;

    // #################################################################

//    [self.chassis addWheelAt:(cpVect){ 50, carY } radius:tireRadius motorized:YES rate:kWheelRate];

    self.frontWheel = [[[CPhysicsBody alloc] initWithMass:100 inertia:100] autorelease];
    self.frontWheel.position = (cpVect){ 50, carY };
    [self.chassis addSubbody:self.frontWheel];

    CPhysicsShape *theFrontWheelShape = [CPhysicsShape ballShapeWithBody:self.frontWheel radius:tireRadius];
    theFrontWheelShape.group = 1;
    theFrontWheelShape.elasticity = 1.4;
    theFrontWheelShape.friction = 10.0;
    [self.frontWheel addShape:theFrontWheelShape];

    // #################################################################

    self.rearWheel = [[[CPhysicsBody alloc] initWithMass:100 inertia:100] autorelease];
    self.rearWheel.position = (cpVect){ -50, carY };
    [self.chassis addSubbody:self.rearWheel];

    CPhysicsShape *theRearWheelShape = [CPhysicsShape ballShapeWithBody:self.rearWheel radius:tireRadius];
    theRearWheelShape.group = 1;
    theRearWheelShape.elasticity = 1.4;
    theRearWheelShape.friction = 10.0;
    [self.rearWheel addShape:theRearWheelShape];

    // #################################################################

    CPhysicsConstraint *theRearWheelPivot = [[[CPhysicsConstraint alloc] initWithConstraint:cpPivotJointNew2(self.chassis.body, self.rearWheel.body, (cpVect){ -50, 0 }, (cpVect){ 0, 0 })] autorelease];
    [self.chassis addConstraint:theRearWheelPivot];
    
    CPhysicsConstraint *theFrontWheelPivot = [[[CPhysicsConstraint alloc] initWithConstraint:cpPivotJointNew2(self.chassis.body, self.frontWheel.body, (cpVect){ 50, 0 }, (cpVect){ 0, 0 })] autorelease];
    [self.chassis addConstraint:theFrontWheelPivot];

    // #################################################################

    CPhysicsConstraint *theRearWheelMotor = [[[CPhysicsConstraint alloc] initWithConstraint:cpSimpleMotorNew(self.frontWheel.body, self.chassis.body, kWheelRate)] autorelease];
    [self.chassis addConstraint:theRearWheelMotor];

    CPhysicsConstraint *theFrontWheelMotor = [[[CPhysicsConstraint alloc] initWithConstraint:cpSimpleMotorNew(self.rearWheel.body, self.chassis.body, kWheelRate)] autorelease];
    [self.chassis addConstraint:theFrontWheelMotor];

    // #################################################################

    self.geometry = (id)self.chassis.geometry;

    }

@end
