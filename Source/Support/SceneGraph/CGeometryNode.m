//
//  CGeometryNode.m
//  Racing Genes
//
//  Created by Jonathan Wight on 09/23/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import "CGeometryNode.h"

#import <QuartzCore/QuartzCore.h>

#import "OpenGLTypes.h"
#import "CVertexBuffer.h"
#import "CProgram.h"
#import "CShader.h"
#import "CTexture.h"
#import "CVertexBufferReference.h"
#import "CSceneGraphRenderer.h"

@implementation CGeometryNode

@synthesize type;
@synthesize indicesBufferReference;
@synthesize coordinatesBufferReference;
@synthesize textureCoordinatesBufferReference;
@synthesize colorsBufferReference;
@synthesize texture;
@synthesize program;
@synthesize vertexBuffers;

- (void)render:(CSceneGraphRenderer *)inRenderer;
    {
    // Use shader program
    glUseProgram(self.program.name);

    AssertOpenGLNoError_();

    // Update uniform value
    GLuint theTransformUniformIndex = [self.program uniformIndexForName:@"transform"];
    Matrix4 theTransform = self.transform;
//    theTransform = Matrix4Concat(theTransform, self.transform);
    theTransform = Matrix4Concat(theTransform, inRenderer.transform);
    theTransform = Matrix4Scale(theTransform, 0.005, 0.005, 1.0);



    glUniformMatrix4fv(theTransformUniformIndex, 1, NO, &theTransform.m00);

    

    // Update attribute values
    if (self.coordinatesBufferReference)
        {
        const GLuint theVertexAttributeIndex = [self.program attributeIndexForName:@"vertex"];
        glBindBuffer(GL_ARRAY_BUFFER, self.coordinatesBufferReference.vertexBuffer.name);
        glVertexAttribPointer(theVertexAttributeIndex, self.coordinatesBufferReference.size, self.coordinatesBufferReference.type, self.coordinatesBufferReference.normalized, self.coordinatesBufferReference.stride, NULL);
        glEnableVertexAttribArray(theVertexAttributeIndex);
        }
    else
        {
        const GLuint theVertexAttributeIndex = [self.program attributeIndexForName:@"vertex"];
        glDisableVertexAttribArray(theVertexAttributeIndex);
        }


    if (self.colorsBufferReference)
        {
        const GLuint theColorAttributeIndex = [self.program attributeIndexForName:@"color"];
        glBindBuffer(GL_ARRAY_BUFFER, self.colorsBufferReference.vertexBuffer.name);
        glVertexAttribPointer(theColorAttributeIndex, self.colorsBufferReference.size, self.colorsBufferReference.type, self.colorsBufferReference.normalized, self.colorsBufferReference.stride, NULL);
        glEnableVertexAttribArray(theColorAttributeIndex);
        }
    else
        {
        const GLuint theVertexAttributeIndex = [self.program attributeIndexForName:@"color"];
        glDisableVertexAttribArray(theVertexAttributeIndex);
        }
    
    if (self.textureCoordinatesBufferReference)
        {
        const GLuint theTextureAttributeIndex = [self.program attributeIndexForName:@"texture"];
        glBindBuffer(GL_ARRAY_BUFFER, self.textureCoordinatesBufferReference.vertexBuffer.name);
        glVertexAttribPointer(theTextureAttributeIndex, self.textureCoordinatesBufferReference.size, self.textureCoordinatesBufferReference.type, self.textureCoordinatesBufferReference.normalized, self.textureCoordinatesBufferReference.stride, NULL);
        glEnableVertexAttribArray(theTextureAttributeIndex);

        glBindTexture(GL_TEXTURE_2D, self.texture.name);
        }
    else
        {
        const GLuint theVertexAttributeIndex = [self.program attributeIndexForName:@"texture"];
        glDisableVertexAttribArray(theVertexAttributeIndex);
        }
        

    // Validate program before drawing. This is a good check, but only really necessary in a debug build. DEBUG macro must be defined in your debug configurations if that's not already the case.
#if defined(DEBUG)
    NSError *theError = NULL;
    if ([self.program validate:&theError] == NO)
        {
        NSLog(@"Failed to validate program: %@", theError);
        return;
        }
#endif

    // Draw

    if (self.indicesBufferReference)
        {
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, self.indicesBufferReference.vertexBuffer.name);
        glDrawElements(self.type, self.indicesBufferReference.cellCount, self.indicesBufferReference.type, NULL);
        }
    else
        {
        glDrawArrays(self.type, 0, self.coordinatesBufferReference.cellCount);
        }
        
    AssertOpenGLNoError_();



    }

@end
