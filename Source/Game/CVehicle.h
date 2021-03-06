//
//  CVehicle.h
//  
//
//  Created by Jonathan Wight on 02/03/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CSceneNode;
@class CPhysicsBody;

@interface CVehicle : NSObject {

}

@property (readwrite, nonatomic, retain) CPhysicsBody *chassis;
@property (readwrite, nonatomic, retain) CSceneNode *geometry;


@end
