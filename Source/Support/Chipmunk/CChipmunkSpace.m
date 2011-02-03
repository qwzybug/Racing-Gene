//
//  CChipmunkSpace.m
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CChipmunkSpace.h"

#import "CChipmunkBody.h"
#import "CChipmunkShape.h"

@interface CChipmunkSpace ()
@property (readwrite, nonatomic, retain) NSMutableArray *bodies;
@property (readwrite, nonatomic, retain) NSMutableArray *shapes;
@end

@implementation CChipmunkSpace

@synthesize space;
@synthesize staticBody;
@synthesize simulationRate;
@synthesize simulationSteps;

@synthesize bodies;
@synthesize shapes;

- (id)init
    {
    if ((self = [super init]) != NULL)
        {
        cpInitChipmunk();

        space = cpSpaceNew();
//        space->iterations = 100;
//        space->elasticIterations = 10;
//        space->damping = 0.1;

        bodies = [[NSMutableArray alloc] init];
        shapes = [[NSMutableArray alloc] init];
        
        simulationRate = 8.0;
        simulationSteps = 100;
        }
    return(self);
    }

- (id)initWithGravity:(cpVect)inGravity
    {
    if ((self = [self init]) != NULL)
        {
        space->gravity = inGravity;
//        space->iterations = 100;
//        space->elasticIterations = 10;
//        space->damping = 0.1;
        }
    return(self);
    }    

- (void)dealloc
    {
    cpSpaceDestroy(self.space);
    //
    [super dealloc];
    }

#pragma mark -

- (CChipmunkBody *)staticBody
    {
    if (staticBody == NULL)
        {
        // TODO what about releasing?
        cpBody *x = &self.space->staticBody;
        staticBody = [[CChipmunkBody alloc] initWithBody:x];
        }
    return(staticBody);
    }

- (void)addBody:(CChipmunkBody *)inBody;
    {
    cpSpaceAddBody(self.space, inBody.body);
    [self.bodies addObject:inBody];
    }

- (void)addShape:(CChipmunkShape *)inShape;
    {
    cpSpaceAddShape(self.space, inShape.shape);
    [self.shapes addObject:inShape];
    }

- (void)addStaticShape:(CChipmunkShape *)inShape;
    {
    cpSpaceAddStaticShape(self.space, inShape.shape);
    [self.shapes addObject:inShape];
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
