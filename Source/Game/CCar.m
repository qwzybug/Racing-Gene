//
//  CCar.m
//  Racing Gene
//
//  Created by Jonathan Wight on 02/03/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CCar.h"

#include "chipmunk.h"

#import "CPhysicsBody.h"
#import "CSceneGeometry.h"
#import "CPhysicsShape.h"
#import "CSceneGeometry.h"
#import "CPhysicsShape_GeometryExtensions.h"
#import "CSceneGeometry_ConvenienceExtensions.h"

@implementation CCar

@synthesize geometry;
@synthesize body;

- (id)init
    {
    if ((self = [super init]) != NULL)
        {
        CGFloat carY = 100;

        // #################################################################################################################

        CPhysicsBody *theChassisBody = [[[CPhysicsBody alloc] initWithMass:100 inertia:100] autorelease];
        theChassisBody.position = (cpVect){ 0, 50 };
//        [self.chipmunkSpace addBody:theChassisBody];

        self.body = theChassisBody;

        CPhysicsShape *theChassisShape = [CPhysicsShape boxShapeWithBody:theChassisBody size:(CGSize){ 100, 5 }];
        theChassisShape.group = 1;
        theChassisShape.elasticity = 1.4;
        theChassisShape.friction = 0.5;
//        [self.chipmunkSpace addShape:theChassisShape];

        // #################################################################################################################

        CSceneGeometry *theChassisNode = [CSceneGeometry flatGeometryNodeWithCoordinatesBuffer:[theChassisShape vertexBuffer]];
    //    theChassisNode.transform = theChassisBody.modelMatrix;
        theChassisShape.userInfo = theChassisNode;

        // #################################################################################################################

        CGFloat tireRadius = 40.0;
        CGFloat kWheelRate = -10;

        // #################################################################################################################

        CPhysicsBody *theFrontWheelBody = [[[CPhysicsBody alloc] initWithMass:100 inertia:100] autorelease];
        theFrontWheelBody.position = (cpVect){ 50, carY };
//        [self.chipmunkSpace addBody:theFrontWheelBody];

        CPhysicsShape *theFrontWheelShape = [CPhysicsShape ballShapeWithBody:theFrontWheelBody radius:tireRadius];
        theFrontWheelShape.group = 1;
        theFrontWheelShape.elasticity = 1.4;
        theFrontWheelShape.friction = 10.0;
//        [self.chipmunkSpace addShape:theFrontWheelShape];

        // #################################################################################################################

        CSceneGeometry *theFrontWheelNode = [CSceneGeometry circleGeometryNodeWithRadius:cpCircleShapeGetRadius(theFrontWheelShape.shape)];
    //    theFrontWheelNode.transform = theFrontWheelBody.modelMatrix;
        theFrontWheelShape.userInfo = theFrontWheelNode;

        // #################################################################################################################

        CPhysicsBody *theRearWheelBody = [[[CPhysicsBody alloc] initWithMass:100 inertia:100] autorelease];
        theRearWheelBody.position = (cpVect){ -50, carY };
//        [self.chipmunkSpace addBody:theRearWheelBody];

        CPhysicsShape *theRearWheelShape = [CPhysicsShape ballShapeWithBody:theRearWheelBody radius:tireRadius];
        theRearWheelShape.group = 1;
        theRearWheelShape.elasticity = 1.4;
        theRearWheelShape.friction = 10.0;
//        [self.chipmunkSpace addShape:theRearWheelShape];

        // #################################################################################################################

        CSceneGeometry *theRearWheelNode = [CSceneGeometry circleGeometryNodeWithRadius:cpCircleShapeGetRadius(theRearWheelShape.shape)];
    //    theRearWheelNode.transform = theRearWheelBody.modelMatrix;
        theRearWheelShape.userInfo = theRearWheelNode;

        // #################################################################################################################

//        cpSpaceAddConstraint(self.chipmunkSpace.space, cpPivotJointNew2(theChassisBody.body, theRearWheelBody.body, (cpVect){ -50, 0 }, (cpVect){ 0, 0 }));
//        cpSpaceAddConstraint(self.chipmunkSpace.space, cpPivotJointNew2(theChassisBody.body, theFrontWheelBody.body, (cpVect){ 50, 0 }, (cpVect){ 0, 0 }));

//        cpSpaceAddConstraint(self.chipmunkSpace.space, cpSimpleMotorNew(theFrontWheelBody.body, theChassisBody.body, kWheelRate));
//        cpSpaceAddConstraint(self.chipmunkSpace.space, cpSimpleMotorNew(theRearWheelBody.body, theChassisBody.body, kWheelRate));

        // #################################################################################################################
        }
    return(self);
    }

@end
