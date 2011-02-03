//
//  CTextureLoader.m
//  Racing Genes
//
//  Created by Jonathan Wight on 09/14/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import "CTextureLoader.h"

@implementation CTextureLoader

+ (id)textureLoader;
    {
    return([[[self alloc] init] autorelease]);
    }

- (CTexture *)textureWithData:(NSData *)inData error:(NSError **)outError
    {
    return(NULL);
    }

- (CTexture *)textureWithPath:(NSString *)inPath error:(NSError **)outError
    {
    NSData *theData = [NSData dataWithContentsOfFile:inPath options:0 error:outError];
    CTexture *theTexture = [self textureWithData:theData error:outError];
    return(theTexture);
    }

@end
