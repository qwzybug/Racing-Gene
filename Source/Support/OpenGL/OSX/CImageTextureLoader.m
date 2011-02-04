//
//  CImageTextureLoader.m
//  Racing Genes
//
//  Created by Jonathan Wight on 09/14/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import "CImageTextureLoader.h"

#import <OpenGL/OpenGL.h>

#import "CTexture.h"

@implementation CImageTextureLoader

- (CTexture *)textureWithData:(NSData *)inData error:(NSError **)outError
    {
    NSImage *theImage = [[[NSImage alloc] initWithData:inData] autorelease];
    CTexture *theTexture = [self textureWithImage:theImage error:outError];
    return(theTexture);
    }

- (CTexture *)textureWithPath:(NSString *)inPath error:(NSError **)outError
    {
    NSImage *theImage = [[[NSImage alloc] initWithContentsOfFile:inPath] autorelease];
    CTexture *theTexture = [self textureWithImage:theImage error:outError];
    return(theTexture);
    }

- (CTexture *)textureWithImage:(NSImage *)inImage error:(NSError **)outError;
    {
    CGImageRef theImageRef = [inImage CGImageForProposedRect:NULL context:NULL hints:NULL];
    
    CGColorSpaceRef theColorSpace = CGImageGetColorSpace(theImageRef);
    CGColorSpaceModel theModel = CGColorSpaceGetModel(theColorSpace);
//        NSLog(@"Model: %d", theModel);
    CGImageAlphaInfo theAlphaInfo = CGImageGetAlphaInfo(theImageRef);
//        NSLog(@"Alpha Info: %d", theAlphaInfo);
    size_t theBitsPerComponent = CGImageGetBitsPerComponent(theImageRef);
//        NSLog(@"%d", theBitsPerComponent);


    GLint theFormat = 0;
    GLint theType = 0;

    NSData *theData = NULL;

    if (theModel == kCGColorSpaceModelRGB && theAlphaInfo == kCGImageAlphaLast && theBitsPerComponent == 8)
        {
        theFormat = GL_RGBA;
        theType = GL_UNSIGNED_BYTE;
        theData = [(NSData *)CGDataProviderCopyData(CGImageGetDataProvider(theImageRef)) autorelease];
        }
    else
        {
        theFormat = GL_RGBA;
        theType = GL_UNSIGNED_BYTE;

        NSLog(@"Unknown model (%d), alpha (%d) or bits per component (%ld)", theModel, theAlphaInfo, theBitsPerComponent);
        
        NSMutableData *theMutableData = [NSMutableData dataWithLength:inImage.size.width * 4 * inImage.size.height];
        theData = theMutableData;
        CGContextRef theImageContext = CGBitmapContextCreate([theMutableData mutableBytes], inImage.size.width, inImage.size.height, 8, inImage.size.width * 4, CGImageGetColorSpace(theImageRef), kCGImageAlphaPremultipliedLast);

        CGContextDrawImage(theImageContext, (CGRect){ .size = inImage.size }, theImageRef);
        CGContextRelease(theImageContext);
        }

    if (theFormat != 0 && theType != 0)
        {
        GLuint theName = 0;
        glGenTextures(1, &theName);
        glBindTexture(GL_TEXTURE_2D, theName);

        glTexImage2D(GL_TEXTURE_2D, 0, theFormat, CGImageGetWidth(theImageRef), CGImageGetHeight(theImageRef), 0, theFormat, theType, theData.bytes);

//        glGenerateMipmap(GL_TEXTURE_2D);

        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);

        GLenum theError = glGetError();
        if (theError != GL_NO_ERROR)
            {
            NSLog(@"Image Loader Error?: %x", theError);
            }

        glBindTexture(GL_TEXTURE_2D, 0);
        
        CTexture *theTexture = [[[CTexture alloc] initWithName:theName width:inImage.size.width height:inImage.size.height] autorelease];
        return(theTexture);
        } 

    return(NULL);
    }

@end
