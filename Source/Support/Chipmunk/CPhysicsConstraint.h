//
//  CPhysicsConstraint.h
//  Racing Gene
//
//  Created by Jonathan Wight on 02/03/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <chipmunk.h>

@interface CPhysicsConstraint : NSObject {

}

@property (readwrite, nonatomic, assign) cpConstraint *constraint;

- (id)initWithConstraint:(cpConstraint *)inConstraint;

@end
