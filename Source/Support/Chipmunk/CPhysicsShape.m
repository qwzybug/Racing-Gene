//
//  CPhysicsShape.m
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CPhysicsShape.h"

#import "CPhysicsBody.h"

@interface CPhysicsShape ()
@end

@implementation CPhysicsShape

@synthesize shape;
@synthesize body;
@synthesize userInfo;

+ (CPhysicsShape *)ballShapeWithBody:(CPhysicsBody *)inBody radius:(cpFloat)inRadius
    {
    return([[[self alloc] initWithShape:cpCircleShapeNew(inBody.body, inRadius, (cpVect){ 0.0, 0.0 })] autorelease]);
    }

+ (CPhysicsShape *)boxShapeWithBody:(CPhysicsBody *)inBody size:(CGSize)inSize;
    {
    return([[[self alloc] initWithShape:cpBoxShapeNew(inBody.body, inSize.width, inSize.height)] autorelease]);
    }

+ (CPhysicsShape *)segmentShapeWithBody:(CPhysicsBody *)inBody start:(cpVect)inStart end:(cpVect)inEnd radius:(cpFloat)inRadius
    {
    return([[[self alloc] initWithShape:cpSegmentShapeNew(inBody.body, inStart, inEnd, inRadius)] autorelease]);
    }

- (id)initWithShape:(cpShape *)inShape
    {
    if ((self = [super init]) != NULL)
        {
        shape = inShape;
        shape->data = self;
        body = [AssertCast_(CPhysicsBody, shape->body->data) retain];
        }
    return(self);
    }

- (cpGroup)group
    {
    return(self.shape->group);
    }

- (void)setGroup:(cpGroup)inGroup
    {
    self.shape->group = inGroup;
    }

- (cpFloat)friction
    {
    return(self.shape->u);
    }

- (void)setFriction:(cpFloat)inFriction
    {
    self.shape->u = inFriction;
    }

- (cpFloat)elasticity
    {
    return(self.shape->e);
    }

- (void)setElasticity:(cpFloat)inElasticity
    {
    self.shape->e = inElasticity;
    }


@end
