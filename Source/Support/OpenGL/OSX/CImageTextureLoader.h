//
//  CImageTextureLoader.h
//  Racing Genes
//
//  Created by Jonathan Wight on 09/14/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import "CTextureLoader.h"

@interface CImageTextureLoader : CTextureLoader {

}

- (CTexture *)textureWithImage:(NSImage *)inImage error:(NSError **)outError;

@end
