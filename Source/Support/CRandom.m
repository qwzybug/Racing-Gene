//
//  CRandom.m
//  Racing Gene
//
//  Created by Jonathan Wight on 02/02/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CRandom.h"


@implementation CRandom

- (u_int32_t)random
    {
    return(arc4random());
    }

@end
