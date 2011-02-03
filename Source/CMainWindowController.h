//
//  CMainWindowController.h
//  Racing Gene
//
//  Created by Jonathan Wight on 01/22/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CRendererView2;

@interface CMainWindowController : NSWindowController {
    
}

@property (readwrite, nonatomic, retain) IBOutlet CRendererView2 *rendererView;


@end

