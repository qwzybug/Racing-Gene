//
//  CMutableVertexBuffer.m
//  Racing Genes
//
//  Created by Jonathan Wight on 09/08/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import "CMutableVertexBuffer.h"

@implementation CMutableVertexBuffer

- (NSMutableData *)mutableData
    {
    // TODO use assert cast
    return((NSMutableData *)self.data);
    }

- (void)update:(NSRange)inRange
    {
    glBindBuffer(self.target, self.name);
    glBufferSubData(self.target, inRange.location, inRange.length, [self.mutableData mutableBytes]);
    // TODO: either skip this - or save/restore previous value
//    glBindBuffer(GL_ARRAY_BUFFER, 0);
    }

- (void)update;
    {
    glBindBuffer(self.target, self.name);
    glBufferSubData(self.target, 0, [self.mutableData length], [self.mutableData mutableBytes]);
    }

@end
