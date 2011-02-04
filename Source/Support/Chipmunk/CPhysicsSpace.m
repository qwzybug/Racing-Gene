//
//  CPhysicsSpace.m
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CPhysicsSpace.h"

#import "CPhysicsBody.h"
#import "CPhysicsShape.h"
#import "CPhysicsConstraint.h"

@interface CPhysicsSpace ()
@property (readwrite, nonatomic, retain) NSMutableArray *mutableBodies;
@property (readwrite, nonatomic, retain) NSMutableArray *mutableShapes;
@property (readwrite, nonatomic, retain) NSMutableArray *mutableConstraints;
@end

@implementation CPhysicsSpace

@synthesize space;
@synthesize staticBody;
@synthesize simulationRate;
@synthesize simulationSteps;

@synthesize mutableBodies;
@synthesize mutableShapes;
@synthesize mutableConstraints;

- (id)init
    {
    if ((self = [super init]) != NULL)
        {
        cpInitChipmunk();

        space = cpSpaceNew();
//        space->iterations = 100;
//        space->elasticIterations = 10;
//        space->damping = 0.1;

        mutableBodies = [[NSMutableArray alloc] init];
        mutableShapes = [[NSMutableArray alloc] init];
        mutableConstraints = [[NSMutableArray alloc] init];
        
        simulationRate = 1.0;
        simulationSteps = 100;
        }
    return(self);
    }

- (id)initWithGravity:(cpVect)inGravity
    {
    if ((self = [self init]) != NULL)
        {
        space->gravity = inGravity;
        }
    return(self);
    }    

- (void)dealloc
    {
    [mutableBodies release];
    mutableBodies = NULL;
    
    [mutableShapes release];
    mutableShapes = NULL;

    cpSpaceFree(space);
    space = NULL;
    
    //
    [super dealloc];
    }

#pragma mark -

- (CPhysicsBody *)staticBody
    {
    if (staticBody == NULL)
        {
        // TODO what about releasing?
        cpBody *x = &self.space->staticBody;
        staticBody = [[CPhysicsBody alloc] initWithBody:x];
        }
    return(staticBody);
    }

- (void)addBody:(CPhysicsBody *)inBody;
    {
    cpSpaceAddBody(self.space, inBody.body);
    [self.mutableBodies addObject:inBody];

    for (CPhysicsBody *theSubbody in inBody.subbodies)
        {
        [self addBody:theSubbody];
        }
    
    for (CPhysicsShape *theShape in inBody.shapes)
        {
        [self addShape:theShape];
        }

    for (CPhysicsConstraint *theConstraint in inBody.constraints)
        {
        [self addConstraint:theConstraint];
        }
    }

- (void)addShape:(CPhysicsShape *)inShape;
    {
    cpSpaceAddShape(self.space, inShape.shape);
    [self.mutableShapes addObject:inShape];
    }

- (void)addStaticShape:(CPhysicsShape *)inShape;
    {
    cpSpaceAddStaticShape(self.space, inShape.shape);
    [self.mutableShapes addObject:inShape];
    }

- (void)addConstraint:(CPhysicsConstraint *)inConstraint;
    {
    cpSpaceAddConstraint(self.space, inConstraint.constraint);
    [self.mutableConstraints addObject:inConstraint];
    }

#pragma mark -

- (void)step
    {
    for (int N = 0; N != self.simulationSteps * self.simulationRate; ++N)
        {
        cpSpaceStep(self.space, (1.0f / 60.0f) / self.simulationSteps);  
        }
    }

@end
