//
//  CVehicle.m
//  
//
//  Created by Jonathan Wight on 02/03/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CVehicle.h"


@implementation CVehicle

@synthesize chassis;
@synthesize geometry;

- (void)dealloc
    {
    [chassis release];
    chassis = NULL;
    
    [geometry release];
    geometry = NULL;
    
    [super dealloc];
    }

@end
