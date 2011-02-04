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
    self.chassis.position = (cpVect){ 0, carY };

    CPhysicsShape *theBodyShape = [CPhysicsShape boxShapeWithBody:self.chassis size:(CGSize){ 100, 5 }];
    theBodyShape.group = 1;
    theBodyShape.elasticity = 1.4;
    theBodyShape.friction = 0.5;
    [self.chassis addShape:theBodyShape];

    // #################################################################

    [self.chassis addWheelAt:(cpVect){ 50, carY } radius:40.0 motorized:YES rate:-M_PI / 2.0];
    [self.chassis addWheelAt:(cpVect){ -50, carY } radius:25.0 motorized:YES rate:-M_PI];

    // #################################################################

    self.geometry = self.chassis.geometry;

    }

@end
