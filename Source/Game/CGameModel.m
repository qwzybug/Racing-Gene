//
//  CGameModel.m
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CGameModel.h"

#import "CPhysicsSpace.h"
#import "CPhysicsBody.h"
#import "CPhysicsShape.h"
#import "CPhysicsShape_GeometryExtensions.h"
#import "CScene.h"
#import "CSceneGeometry.h"
#import "CSceneGeometry_ConvenienceExtensions.h"
#import "CLandscape.h"
#import "CVertexBuffer.h"

static void updateShape(void *ptr, void* unused);

@interface CGameModel ()
@property (readwrite, nonatomic, retain) CPhysicsSpace *chipmunkSpace;
@property (readwrite, nonatomic, retain) CPhysicsShape *ballShape;

- (void)setup;
@end

#pragma mark -

@implementation CGameModel

@synthesize sceneGraph;
@synthesize carBody;

@synthesize chipmunkSpace;
@synthesize ballShape;

- (id)init
    {
    if ((self = [super init]) != NULL)
        {
        [self setup];
        }
    return(self);
    }

- (void)dealloc
    {
    [sceneGraph release];
    sceneGraph = NULL;

    [chipmunkSpace release];
    chipmunkSpace = NULL;

    //
    [super dealloc];
    }


- (void)setup
    {
    self.sceneGraph = [[[CScene alloc] init] autorelease];


    self.chipmunkSpace = [[[CPhysicsSpace alloc] init] autorelease];

    self.chipmunkSpace.space->gravity = (cpVect){ 0.0, -100.0 };  
    self.chipmunkSpace.space->elasticIterations = 10;
//    self.chipmunkSpace.space->damping = 0;
    self.chipmunkSpace.space->iterations = 50;

    // #################################################################################################################

    GLfloat kLandscapeX = -200.0; 
    GLfloat kLandscapeStride = 40.0;
    GLfloat kYFactor = 0.2;

    CLandscape *theLandscape = [[[CLandscape alloc] init] autorelease];
    [theLandscape update];


    for (int N = 0; N != [theLandscape.heightValues count] - 1; ++N)
        {
        double X = kLandscapeX + N * kLandscapeStride;
        double H0 = [[theLandscape.heightValues objectAtIndex:N] doubleValue] * kYFactor;
        double H1 = [[theLandscape.heightValues objectAtIndex:N + 1] doubleValue] * kYFactor;
        
        cpShape *theSegmentShape = cpSegmentShapeNew(NULL, (cpVect){ X, H0 }, (cpVect){ X + kLandscapeStride, H1 }, 1.0);
        theSegmentShape->e = 0.5;
        theSegmentShape->u = 0.5;
        cpSpaceAddStaticShape(self.chipmunkSpace.space, theSegmentShape);
        }

    NSMutableData *theLandscapeVertexData = [NSMutableData data];
    GLfloat X = 0;
    for (NSNumber *theHeight in theLandscape.heightValues)
        {
        Vector2 theVector = { kLandscapeX + X++ * kLandscapeStride, theHeight.doubleValue * kYFactor };
        [theLandscapeVertexData appendBytes:&theVector length:sizeof(theVector)];
        }

    CVertexBuffer *theLandscapeVertexBuffer = [[[CVertexBuffer alloc] initWithTarget:GL_ARRAY_BUFFER usage:GL_STATIC_DRAW data:theLandscapeVertexData] autorelease];
    CSceneGeometry *theLandscapeNode = [CSceneGeometry flatGeometryNodeWithCoordinatesBuffer:theLandscapeVertexBuffer];

    // #################################################################################################################

    CGFloat carY = 100;

    // #################################################################################################################

    CPhysicsBody *theChassisBody = [[[CPhysicsBody alloc] initWithMass:100 inertia:100] autorelease];
    theChassisBody.position = (cpVect){ 0, 50 };
    [self.chipmunkSpace addBody:theChassisBody];

    self.carBody = theChassisBody;

    CPhysicsShape *theChassisShape = [CPhysicsShape boxShapeWithBody:theChassisBody size:(CGSize){ 100, 5 }];
    theChassisShape.group = 1;
    theChassisShape.elasticity = 1.4;
    theChassisShape.friction = 0.5;
    [self.chipmunkSpace addShape:theChassisShape];

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
    [self.chipmunkSpace addBody:theFrontWheelBody];

    CPhysicsShape *theFrontWheelShape = [CPhysicsShape ballShapeWithBody:theFrontWheelBody radius:tireRadius];
    theFrontWheelShape.group = 1;
    theFrontWheelShape.elasticity = 1.4;
    theFrontWheelShape.friction = 10.0;
    [self.chipmunkSpace addShape:theFrontWheelShape];

    // #################################################################################################################

    CSceneGeometry *theFrontWheelNode = [CSceneGeometry circleGeometryNodeWithRadius:cpCircleShapeGetRadius(theFrontWheelShape.shape)];
//    theFrontWheelNode.transform = theFrontWheelBody.modelMatrix;
    theFrontWheelShape.userInfo = theFrontWheelNode;

    // #################################################################################################################

    CPhysicsBody *theRearWheelBody = [[[CPhysicsBody alloc] initWithMass:100 inertia:100] autorelease];
    theRearWheelBody.position = (cpVect){ -50, carY };
    [self.chipmunkSpace addBody:theRearWheelBody];

    CPhysicsShape *theRearWheelShape = [CPhysicsShape ballShapeWithBody:theRearWheelBody radius:tireRadius];
    theRearWheelShape.group = 1;
    theRearWheelShape.elasticity = 1.4;
    theRearWheelShape.friction = 10.0;
    [self.chipmunkSpace addShape:theRearWheelShape];

    // #################################################################################################################

    CSceneGeometry *theRearWheelNode = [CSceneGeometry circleGeometryNodeWithRadius:cpCircleShapeGetRadius(theRearWheelShape.shape)];
//    theRearWheelNode.transform = theRearWheelBody.modelMatrix;
    theRearWheelShape.userInfo = theRearWheelNode;

    // #################################################################################################################

//    cpSpaceAddConstraint(self.chipmunkSpace.space, cpPivotJointNew(theChassisBody.body, theRearWheelBody.body, (cpVect){ -50, 0 }));
//    cpSpaceAddConstraint(self.chipmunkSpace.space, cpPivotJointNew(theChassisBody.body, theFrontWheelBody.body, (cpVect){ 50, 0 }));

    cpSpaceAddConstraint(self.chipmunkSpace.space, cpPivotJointNew2(theChassisBody.body, theRearWheelBody.body, (cpVect){ -50, 0 }, (cpVect){ 0, 0 }));
    cpSpaceAddConstraint(self.chipmunkSpace.space, cpPivotJointNew2(theChassisBody.body, theFrontWheelBody.body, (cpVect){ 50, 0 }, (cpVect){ 0, 0 }));

//    cpSpaceAddConstraint(self.chipmunkSpace.space, cpPinJointNew(theChassisBody.body, theRearWheelBody.body, (cpVect){ -50, 0 }, (cpVect){ 0, 0 }));
//    cpSpaceAddConstraint(self.chipmunkSpace.space, cpPinJointNew(theChassisBody.body, theFrontWheelBody.body, (cpVect){ 50, 0 }, (cpVect){ 0, 0 }));

    cpSpaceAddConstraint(self.chipmunkSpace.space, cpSimpleMotorNew(theFrontWheelBody.body, theChassisBody.body, kWheelRate));
    cpSpaceAddConstraint(self.chipmunkSpace.space, cpSimpleMotorNew(theRearWheelBody.body, theChassisBody.body, kWheelRate));

    // #################################################################################################################

    self.sceneGraph.nodes = [NSArray arrayWithObjects:
        theLandscapeNode,
        theChassisNode,
        theFrontWheelNode,
        theRearWheelNode,
        NULL];
    }

- (void)update
    {
    [self.chipmunkSpace step];
    cpSpaceHashEach(self.chipmunkSpace.space->activeShapes, &updateShape, nil);
    }


@end

static void updateShape(void *ptr, void *unused)
    {
	// Get our shape
	cpShape *theShape = (cpShape*)ptr;
    CPhysicsShape *theBallShape = theShape->data;
    
    CSceneGeometry *theBallNode = theBallShape.userInfo;
    CPhysicsBody *theBallBody = theBallShape.body;
    
    cpVect thePosition = cpBodyGetPos(theBallBody.body);
    cpFloat theAngle = cpBodyGetAngle(theBallBody.body);
    
    Matrix4 theTransform = Matrix4MakeRotation(-theAngle, 0, 0, 1);
    theTransform = Matrix4Translate(theTransform, thePosition.x, thePosition.y, 0);
    
    theBallNode.transform = theTransform;
    }
