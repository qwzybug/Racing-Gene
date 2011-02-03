//
//  CChipmunkSpace.h
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#include "chipmunk.h"

@class CChipmunkBody;
@class CChipmunkShape;

@interface CChipmunkSpace : NSObject {

}

@property (readonly, nonatomic, assign) cpSpace *space;
@property (readonly, nonatomic, assign) CChipmunkBody *staticBody;

@property (readonly, nonatomic, assign) cpFloat simulationRate;
@property (readonly, nonatomic, assign) cpFloat simulationSteps;;

- (id)init;
- (id)initWithGravity:(cpVect)inGravity;

- (void)addBody:(CChipmunkBody *)inBody;
- (void)addShape:(CChipmunkShape *)inShape;
- (void)addStaticShape:(CChipmunkShape *)inShape;

- (void)step;

@end
