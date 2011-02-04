//
//  CPhysicsBody_GeometryExtensions.m
//  Racing Gene
//
//  Created by Jonathan Wight on 02/03/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CPhysicsBody_GeometryExtensions.h"

#import "CSceneGroup.h"
#import "CPhysicsShape_GeometryExtensions.h"

@implementation CPhysicsBody (CPhysicsBody_GeometryExtensions)

- (CSceneNode *)geometry
    {
    NSMutableArray *theNodes = [NSMutableArray array];
    
    for (CPhysicsBody *theBody in self.subbodies)
        {
        CSceneNode *theGeometry = theBody.geometry;
        [theNodes addObject:theGeometry];
        }
    
    for (CPhysicsShape *theShape in self.shapes)
        {
        CSceneNode *theGeometry = theShape.geometry;
        [theNodes addObject:theGeometry];
        }
    
    CSceneGroup *theGeometry = [[[CSceneGroup alloc] init] autorelease];
    theGeometry.nodes = theNodes;
    
    NSLog(@"%@", theGeometry.nodes);
    
    return(theGeometry); 
    }

@end
