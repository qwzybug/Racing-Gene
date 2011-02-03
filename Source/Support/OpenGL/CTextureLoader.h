//
//  CTextureLoader.h
//  Racing Genes
//
//  Created by Jonathan Wight on 09/14/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CTexture;

@interface CTextureLoader : NSObject {

}

+ (id)textureLoader;

- (CTexture *)textureWithData:(NSData *)inData error:(NSError **)outError;
- (CTexture *)textureWithPath:(NSString *)inPath error:(NSError **)outError;

@end
