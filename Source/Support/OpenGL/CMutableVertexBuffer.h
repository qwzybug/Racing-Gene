//
//  CMutableVertexBuffer.h
//  Racing Genes
//
//  Created by Jonathan Wight on 09/08/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import "CVertexBuffer.h"

@interface CMutableVertexBuffer : CVertexBuffer {

}

@property (readonly, nonatomic, retain) NSMutableData *mutableData;

- (void)update:(NSRange)inRange;

- (void)update;

@end
