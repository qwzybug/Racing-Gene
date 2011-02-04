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

@class CPhysicsShape;

@interface CPhysicsBody : NSObject {

}

@property (readonly, nonatomic, assign) cpBody *body;
@property (readwrite, nonatomic, assign) cpVect position;
@property (readonly, nonatomic, assign) Matrix4 modelMatrix;

+ (CPhysicsBody *)staticBody;

- (id)initWithBody:(cpBody *)inBody;
- (id)initWithMass:(cpFloat)inMass inertia:(cpFloat)inInertia;

@end
