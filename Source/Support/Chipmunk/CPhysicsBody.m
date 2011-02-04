//
//  CPhysicsBody.m
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CPhysicsBody.h"

@interface CPhysicsBody ()

@property (readwrite, nonatomic, retain) NSMutableArray *mutableSubbodies;
@property (readwrite, nonatomic, retain) NSMutableArray *mutableShapes;
@property (readwrite, nonatomic, retain) NSMutableArray *mutableConstraints;

@end

#pragma mark -

@implementation CPhysicsBody

@synthesize body;

@synthesize mutableSubbodies;
@synthesize mutableShapes;
@synthesize mutableConstraints;

+ (CPhysicsBody *)staticBody
    {
    return([[[CPhysicsBody alloc] initWithBody:cpBodyNewStatic()] autorelease]);
    }

- (id)initWithBody:(cpBody *)inBody;
    {
    if ((self = [super init]) != NULL)
        {
        body = inBody;
        body->data = self;
        }
    return(self);
    }

- (id)initWithMass:(cpFloat)inMass inertia:(cpFloat)inInertia
    {
    if ((self = [self initWithBody:cpBodyNew(inMass, inInertia)]) != NULL)
        {
        }
    return(self);
    }
    
- (void)dealloc
    {
    [mutableSubbodies release];
    mutableSubbodies = NULL;
    
    [mutableShapes release];
    mutableShapes = NULL;
    
    cpBodyFree(body);
    body = NULL;
    //
    [super dealloc];
    }
    
#pragma mark -

- (NSArray *)subbodies
    {
    return(self.mutableSubbodies);
    }

    
- (NSArray *)shapes
    {
    return(self.mutableShapes);
    }
    
- (NSArray *)constraints
    {
    return(self.mutableConstraints);
    }
    
#pragma mark -    

- (cpVect)position
    {
    return(cpBodyGetPos(self.body));
    }

- (void)setPosition:(cpVect)inPosition
    {
    cpBodySetPos(self.body, inPosition);
    }
    

- (Matrix4)modelMatrix
    {
    cpVect thePosition = cpBodyGetPos(self.body);
    return(Matrix4MakeTranslation(thePosition.x, thePosition.y, 0));
    }

#pragma mark -

- (void)addSubbody:(CPhysicsBody *)inSubbody
    {
    if (self.mutableSubbodies == NULL)
        {
        self.mutableSubbodies = [NSMutableArray array];
        }
    [self.mutableSubbodies addObject:inSubbody];
    }

- (void)addShape:(CPhysicsShape *)inShape
    {
    if (self.mutableShapes == NULL)
        {
        self.mutableShapes = [NSMutableArray array];
        }
    [self.mutableShapes addObject:inShape];
    }

- (void)addConstraint:(CPhysicsConstraint *)inConstraint
    {
    if (self.mutableConstraints == NULL)
        {
        self.mutableConstraints = [NSMutableArray array];
        }
    [self.mutableConstraints addObject:inConstraint];
    }


@end
