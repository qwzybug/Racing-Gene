//
//  CPhysicsBody_Extensions.m
//  Racing Gene
//
//  Created by Jonathan Wight on 02/03/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CPhysicsBody_Extensions.h"


@implementation CPhysicsBody (CPhysicsBody_Extensions)

- (CPhysicsShape *)shape
    {
    return([self.shapes lastObject]);
    }

@end
