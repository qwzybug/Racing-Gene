//
//  CTexture_TilingExtension.h
//  Racing Genes
//
//  Created by Jonathan Wight on 09/14/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import "CTexture.h"

@interface CTexture (CTexture_TilingExtension)

- (void)getVertices:(GLfloat *)outVertices tileSize:(CGSize)inTileSize forSubtextureAtX:(NSUInteger)X Y:(NSUInteger)Y;

@end
