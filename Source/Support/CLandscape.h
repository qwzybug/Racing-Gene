//
//  CLandscape.h
//  Racing Gene
//
//  Created by Jonathan Wight on 02/01/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CLandscape : NSObject {

}

@property (readwrite, nonatomic, retain) NSMutableArray *heightValues;

- (void)update;

@end
