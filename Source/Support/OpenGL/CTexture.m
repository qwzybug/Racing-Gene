//
//  CTexture.m
//  Racing Genes
//
//  Created by Jonathan Wight on 09/06/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import "CTexture.h"

@implementation CTexture

@synthesize name;
@synthesize width;
@synthesize height;
@synthesize internalFormat;
@synthesize hasAlpha;

- (id)initWithName:(GLuint)inName width:(GLuint)inWidth height:(GLuint)inHeight;
    {
    if ((self = [super init]) != NULL)
        {
        name = inName;
        width = inWidth;
        height = inHeight;
        }
    return(self);
    }

- (void)dealloc
    {
    if (name != 0)
        {
        glDeleteTextures(1, &name);
        name = 0;
        }
    //
    [super dealloc];
    }

@end
