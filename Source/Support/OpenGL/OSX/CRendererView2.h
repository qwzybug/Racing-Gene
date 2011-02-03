//
//  CRendererView2.h
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CRendererOpenGLLayer;

@interface CRendererView2 : NSView {

}

@property (readonly, nonatomic, retain) CRendererOpenGLLayer *rendererLayer;

@end
