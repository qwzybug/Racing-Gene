//
//  CCar.h
//  Racing Gene
//
//  Created by Jonathan Wight on 02/03/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CGeometryNode;
@class CChipmunkBody;

@interface CCar : NSObject {

}

@property (readwrite, nonatomic, retain) CGeometryNode *geometry;
@property (readwrite, nonatomic, retain) CChipmunkBody *body;

@end
