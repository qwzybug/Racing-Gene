//
//  CPhysicsBody.h
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "chipmunk.h"

#import "OpenGLTypes.h"

@class CPhysicsConstraint;
@class CPhysicsShape;

@interface CPhysicsBody : NSObject {

}

@property (readonly, nonatomic, assign) cpBody *body;

@property (readonly, nonatomic, retain) NSArray *subbodies;
@property (readonly, nonatomic, retain) NSArray *shapes;
@property (readonly, nonatomic, retain) NSArray *constraints;

@property (readwrite, nonatomic, assign) cpVect position;
@property (readonly, nonatomic, assign) Matrix4 modelMatrix;

+ (CPhysicsBody *)staticBody;

- (id)initWithBody:(cpBody *)inBody;
- (id)initWithMass:(cpFloat)inMass inertia:(cpFloat)inInertia;

- (void)addSubbody:(CPhysicsBody *)inSubbody;
- (void)addShape:(CPhysicsShape *)inShape;
- (void)addConstraint:(CPhysicsConstraint *)inConstraint;

@end
