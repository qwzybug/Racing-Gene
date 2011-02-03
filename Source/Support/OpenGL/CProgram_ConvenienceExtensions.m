//
//  CProgram_ConvenienceExtensions.m
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CProgram_ConvenienceExtensions.h"

#import "CShader.h"

@implementation CProgram (CProgram_ConvenienceExtensions)

- (id)initWithFilename:(NSString *)inFilename attributeNames:(NSArray *)inAttributeNames uniformNames:(NSArray *)inUniformNames;
    {
    NSArray *theFiles = [NSArray arrayWithObjects:
        [[[CShader alloc] initWithName:[NSString stringWithFormat:@"%@.fsh", inFilename]] autorelease],
        [[[CShader alloc] initWithName:[NSString stringWithFormat:@"%@.vsh", inFilename]] autorelease],
        NULL];
    
    if ((self = [self initWithFiles:theFiles attributeNames:inAttributeNames uniformNames:inUniformNames]) != NULL)
        {
        }
    return(self);
    }

@end
