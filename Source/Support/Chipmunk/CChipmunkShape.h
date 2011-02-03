//
//  CChipmunkShape.h
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#include "chipmunk.h"

@class CChipmunkBody;

@interface CChipmunkShape : NSObject {

}

@property (readonly, nonatomic, assign) cpShape *shape;
@property (readonly, nonatomic, assign) CChipmunkBody *body;
@property (readwrite, nonatomic, assign) id userInfo;
@property (readwrite, nonatomic, assign) cpGroup group;
@property (readwrite, nonatomic, assign) cpFloat friction;
@property (readwrite, nonatomic, assign) cpFloat elasticity;

+ (CChipmunkShape *)ballShapeWithBody:(CChipmunkBody *)inBody radius:(cpFloat)inRadius;
+ (CChipmunkShape *)boxShapeWithBody:(CChipmunkBody *)inBody size:(CGSize)inSize;
+ (CChipmunkShape *)segmentShapeWithBody:(CChipmunkBody *)inBody start:(cpVect)inStart end:(cpVect)inEnd radius:(cpFloat)inRadius;

- (id)initWithShape:(cpShape *)inShape;

@end
