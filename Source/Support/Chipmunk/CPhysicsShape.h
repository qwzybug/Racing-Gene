//
//  CPhysicsShape.h
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "chipmunk.h"

@class CPhysicsBody;

@interface CPhysicsShape : NSObject {

}

@property (readonly, nonatomic, assign) cpShape *shape;
@property (readonly, nonatomic, assign) CPhysicsBody *body;
@property (readwrite, nonatomic, assign) id userInfo;
@property (readwrite, nonatomic, assign) cpGroup group;
@property (readwrite, nonatomic, assign) cpFloat friction;
@property (readwrite, nonatomic, assign) cpFloat elasticity;

+ (CPhysicsShape *)ballShapeWithBody:(CPhysicsBody *)inBody radius:(cpFloat)inRadius;
+ (CPhysicsShape *)boxShapeWithBody:(CPhysicsBody *)inBody size:(CGSize)inSize;
+ (CPhysicsShape *)segmentShapeWithBody:(CPhysicsBody *)inBody start:(cpVect)inStart end:(cpVect)inEnd radius:(cpFloat)inRadius;

- (id)initWithShape:(cpShape *)inShape;

@end
