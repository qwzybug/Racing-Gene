//
//  CPhysicsConstraint.m
//  Racing Gene
//
//  Created by Jonathan Wight on 02/03/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CPhysicsConstraint.h"


@implementation CPhysicsConstraint

@synthesize constraint;

- (id)initWithConstraint:(cpConstraint *)inConstraint;
    {
    if ((self = [super init]) != NULL)
        {
        constraint = inConstraint;
        constraint->data = self;
        }
    return(self);
    }

- (void)dealloc
    {
    cpConstraintFree(constraint);
    constraint = NULL;
    //
    [super dealloc];
    }

- (void)setConstraint:(cpConstraint *)inConstraint
    {
    if (constraint != inConstraint)
        {
        cpConstraintFree(constraint);
        constraint = NULL;
        
        constraint = inConstraint;
        }
    }

@end
