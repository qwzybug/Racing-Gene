//
//  CTexture_TilingExtension.m
//  Racing Genes
//
//  Created by Jonathan Wight on 09/14/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import "CTexture_TilingExtension.h"

#import "OpenGLTypes.h"

@implementation CTexture (CTexture_TilingExtension)

- (void)getVertices:(GLfloat *)outVertices tileSize:(CGSize)inTileSize forSubtextureAtX:(NSUInteger)X Y:(NSUInteger)Y;
    {
    GLfloat theHCount = self.width / inTileSize.width;
    GLfloat theVCount = self.height / inTileSize.height;
    CGSize theTileTextureSize = { 1.0f / theHCount, 1.0f / theVCount };
    const Vector2 theTextureVertices[] = {
        { X * theTileTextureSize.width, (Y + 1.0f) * theTileTextureSize.height },
        { (X + 1.0f) * theTileTextureSize.width, (Y + 1.0f) * theTileTextureSize.height },
        { X * theTileTextureSize.width, Y * theTileTextureSize.height },
        { (X + 1.0f) * theTileTextureSize.width, Y * theTileTextureSize.height },
        };
    memcpy(outVertices, theTextureVertices, sizeof(theTextureVertices));
    }

- (void)getVertices:(GLfloat *)outVertices tileSize:(CGSize)inTileSize forSubtextureAtIndex:(NSUInteger)inIndex
    {
    
    
    }
    

@end
