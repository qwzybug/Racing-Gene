//
//  CCar.h
//  Racing Gene
//
//  Created by Jonathan Wight on 02/03/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CSceneGeometry;
@class CPhysicsBody;

@interface CCar : NSObject {

}

@property (readwrite, nonatomic, retain) CSceneGeometry *geometry;
@property (readwrite, nonatomic, retain) CPhysicsBody *body;

@end
