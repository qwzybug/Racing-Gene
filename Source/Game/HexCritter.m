//
//  HexCritter.m
//  HexGenome
//
//  Created by Devin Chalmers on 2/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HexCritter.h"


#define MUTATION_RATE 0.2


@interface HexCritter ()
- (hex_gene *)randomGenome;
- (hex_gene)randomGene;
- (void)setGenome:(hex_gene *)newGenome;
@end


hex_gene mutate(hex_gene gene) {
	hex_gene new_gene = gene;
	switch (random() % 3) {
		case 0: // mutate gene type — nothing here yet
		case 1: // mutate gene size
			new_gene.size = random() % 10 + 5;
			break;
		case 2: // mutate position
			new_gene.next_hex = gene.next_hex > -1 ? random() % 6 : -1; // should mutations be able to truncate a genome?
			break;
	}
	NSLog(@"Mutated (%d %d %d) -> (%d %d %d)", gene.type, gene.size, gene.next_hex, new_gene.type, new_gene.size, new_gene.next_hex);
	return new_gene;
}


@implementation HexCritter

@synthesize genome;
@synthesize gene_count;

- (void)dealloc;
{
	free(genome);
	genome = NULL;
	
	[super dealloc];
}

- (id)init;
{
	if (!(self = [super init]))
		return nil;
	
	hex_gene *newGenome = [self randomGenome];
	[self setGenome:newGenome];
	
	return self;
}

- (hex_gene *)randomGenome;
{
	float prob = 0.9;
	float max_size = 100;
	
	int genome_size = 100;
	hex_gene *newGenome = calloc(genome_size, sizeof(hex_gene));
	
	int geneCount = 0;
	do {
		if (geneCount >= genome_size) {
			genome_size = genome_size * 2;
			newGenome = (hex_gene *)realloc(newGenome, genome_size * sizeof(hex_gene));
		}
		newGenome[geneCount++] = [self randomGene];
	} while ((float)random() / INT_MAX < prob && geneCount < max_size);
	
	newGenome[geneCount - 1].next_hex = -1;
	
	return newGenome;
}

- (hex_gene)randomGene;
{
	hex_gene gene;
	gene.type = 0;
	gene.size = random() % 10 + 5;
	gene.next_hex = random() % 6;
	return gene;
}

+ (HexCritter *)critterByBreeding:(HexCritter *)critter with:(HexCritter *)otherCritter;
{
	int firstFlip = random() % critter.gene_count;
	int secondFlip = random() % otherCritter.gene_count;
	int genome_size = firstFlip + (otherCritter.gene_count - secondFlip);
	
	hex_gene *newGenome = calloc(genome_size, sizeof(hex_gene));
	hex_gene gene;
	for (int i = 0; i < firstFlip; i++) {
		gene = critter.genome[i];
		newGenome[i] = ((float)random() / INT_MAX < MUTATION_RATE) ? mutate(gene) : gene;
	}
	for (int i = 0; i < (otherCritter.gene_count - secondFlip); i++) {
		gene = otherCritter.genome[secondFlip + i];
		newGenome[firstFlip + i] = ((float)random() / INT_MAX < MUTATION_RATE) ? mutate(gene) : gene;
	}
	
	HexCritter *child = [[self alloc] init];
	[child setGenome:newGenome];
	return [child autorelease];
}

- (void)setGenome:(hex_gene *)newGenome;
{
	if (genome)	free(genome), genome = NULL;
	
	genome = newGenome;
	
	gene_count = 0;
	hex_gene gene;
	do {
		gene = genome[gene_count++];
	} while (gene.next_hex != -1);
}

@end
