//
//  HexCritter.h
//  HexGenome
//
//  Created by Devin Chalmers on 2/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct _hex_gene {
	int type;
	int size;
	int next_hex; // -1 (none), clockwise from bottom 0-5
} hex_gene;

@interface HexCritter : NSObject {
	hex_gene *genome;
	int gene_count;
}

@property (readonly) hex_gene *genome;
@property (readonly) int gene_count;

+ (HexCritter *)critterByBreeding:(HexCritter *)critter with:(HexCritter *)otherCritter;

@end
