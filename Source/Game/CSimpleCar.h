//
//  CCar.h
//  Racing Gene
//
//  Created by Jonathan Wight on 02/03/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CVehicle.h"

@interface CSimpleCar : CVehicle {

}

@property (readwrite, nonatomic, retain) CPhysicsBody *rearWheel;
@property (readwrite, nonatomic, retain) CPhysicsBody *frontWheel;

@end
