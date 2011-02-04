//
//  HexVehicle.m
//  Racing Gene
//
//  Created by Devin Chalmers on 2/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HexVehicle.h"

#include "chipmunk.h"

#import "CPhysicsBody.h"
#import "CSceneGeometry.h"
#import "CSceneGroup.h"
#import "CPhysicsShape.h"
#import "CSceneGeometry.h"
#import "CPhysicsBody_Extensions.h"
#import "CPhysicsShape_GeometryExtensions.h"
#import "CSceneGeometry_ConvenienceExtensions.h"
#import "CPhysicsConstraint.h"

#import "HexCritter.h"

#define V_H(sz) CGPointMake((sz) + (sz) * sqrt(3) / 4, 0)
#define V_V(sz) CGPointMake(0, (sz) * sqrt(3) / 2)

@interface HexVehicle ()
- (void)setup;
@end


static cpFloat
springForce(cpConstraint *spring, cpFloat dist)
{
	cpFloat clamp = 20.0f;
	return cpfclamp(cpDampedSpringGetRestLength(spring) - dist, -clamp, clamp)*cpDampedSpringGetStiffness(spring);
}


@implementation HexVehicle

@synthesize mainBody;
@synthesize geometry;

@synthesize critter;

- (id)init; // TODO: initWithCritter
{
	if (!(self = [super init]))
		return nil;
	
	[self setup];
	
	return self;
}

- (void)setup;
{
	self.critter = [[[HexCritter alloc] init] autorelease];
	
	CGFloat carY = 100;
    CGFloat kWheelRate = -10;
	
	self.mainBody = [[[CPhysicsBody alloc] initWithMass:100 inertia:100] autorelease];
	self.mainBody.position = (cpVect){ 0, 50 };
		
	CPhysicsShape *theBodyShape = [CPhysicsShape boxShapeWithBody:self.mainBody size:(CGSize){ 5, 5 }];
	theBodyShape.group = 1;
	theBodyShape.elasticity = 1.4;
	theBodyShape.friction = 0.5;
	[self.mainBody addShape:theBodyShape];
	
	int lastW = 5;
	int lastLastW = 5;
	
	CPhysicsBody *lastBody = self.mainBody;
	CPhysicsBody *lastLastBody = self.mainBody;
	NSMutableArray *nodes = [NSMutableArray array];
	
	// add body parts
	cpVect p = self.mainBody.position;
	cpVect lastP = self.mainBody.position;
	cpVect lastLastP = self.mainBody.position;
	int gene_num = 0;
	hex_gene gene;
	do {
		gene = self.critter.genome[gene_num];
		int sz = gene.size;
		
		switch (gene.next_hex) {
			case 0:
				p = (cpVect){p.x - 2 * V_V(sz).x, p.y - 2 * V_V(sz).y};
				break;
			case 1:
				p = (cpVect){p.x - V_H(sz).x - V_V(sz).x, p.y - V_H(sz).y - V_V(sz).y};
				break;
			case 2:
				p = (cpVect){p.x - V_H(sz).x + V_V(sz).x, p.y - V_H(sz).y + V_V(sz).y};
				break;
			case 3:
				p = (cpVect){p.x + 2 * V_V(sz).x, p.y + 2 * V_V(sz).y};
				break;
			case 4:
				p = (cpVect){p.x + V_H(sz).x + V_V(sz).x, p.y + V_H(sz).y + V_V(sz).y};
				break;
			case 5:
				p = (cpVect){p.x + V_H(sz).x - V_V(sz).x, p.y + V_H(sz).y - V_V(sz).y};
				break;
		}
		
		cpVect lastV = (cpVect){ p.x - lastP.x, p.y - lastP.y };
		cpVect lastLastV = (cpVect){ p.x - lastLastP.x, p.y - lastLastP.y };
		
		CGFloat lastD = sqrt(lastV.x * lastV.x + lastV.y * lastV.y);
		CGFloat lastLastD = sqrt(lastLastV.x * lastLastV.x + lastLastV.y * lastLastV.y);
		
		CPhysicsBody *cell = [[[CPhysicsBody alloc] initWithMass:10 inertia:10] autorelease];
		cell.position = p;
		[self.mainBody addSubbody:cell];
		
		CPhysicsShape *cellShape = [CPhysicsShape ballShapeWithBody:cell radius:sz];
		cellShape.group = 1;
		cellShape.elasticity = 1.4;
		cellShape.friction = 10.0;
		[cell addShape:cellShape];
		
		// spring between this point and the last one…
		cpConstraint *spring = cpDampedSpringNew(lastBody.body, cell.body, (cpVect){ 0, 0 }, (cpVect){ 0, 0 }, lastD, 500.0, 0.1);
		cpDampedSpringSetSpringForceFunc(spring, springForce);
		CPhysicsConstraint *springConstraint = [[[CPhysicsConstraint alloc] initWithConstraint:spring] autorelease];
		[self.mainBody addConstraint:springConstraint];
		
		// and between this point and the origin
		cpConstraint *spring2 = cpDampedSpringNew(lastLastBody.body, cell.body, (cpVect){ 0, 0 }, (cpVect){ 0, 0 }, lastLastD, 500.0, 0.1);
		cpDampedSpringSetSpringForceFunc(spring2, springForce);
		CPhysicsConstraint *spring2Constraint = [[[CPhysicsConstraint alloc] initWithConstraint:spring2] autorelease];
		[self.mainBody addConstraint:spring2Constraint];
		
		CSceneGeometry *cellNode = [CSceneGeometry circleGeometryNodeWithRadius:sz];
		cellShape.userInfo = cellNode;
		
		[nodes addObject:cellNode];
		
		lastLastBody = lastBody;
		lastBody = cell;
		
		lastLastW = lastW;
		lastW = lastD;
		
		// compute next body position
		if (gene.next_hex != -1)
			sz = (sz + self.critter.genome[gene_num + 1].size) / 2;
		
		lastLastP = lastP;
		lastP = p;

		
		gene_num++;
	} while (gene.next_hex != -1 && gene_num);
	
	CSceneGeometry *theChassisNode = [CSceneGeometry flatGeometryNodeWithCoordinatesBuffer:[self.mainBody.shape vertexBuffer]];
    theBodyShape.userInfo = theChassisNode;
	
	[nodes insertObject:theChassisNode atIndex:0];
	
    CSceneGroup *theGroup = [[[CSceneGroup alloc] init] autorelease];
    theGroup.nodes = nodes;

    self.geometry = (id)theGroup;
}

@end