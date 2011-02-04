//
//  CPhysicsShape_GeometryExtensions.m
//  Racing Gene
//
//  Created by Jonathan Wight on 01/31/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CPhysicsShape_GeometryExtensions.h"

#import "OpenGLTypes.h"
#import "CVertexBuffer_FactoryExtensions.h"
#import "CVertexBufferReference.h"

@implementation CPhysicsShape (CPhysicsShape_GeometryExtensions)

- (CVertexBuffer *)vertexBuffer
    {
    cpShape *theShape = self.shape;

    CVertexBuffer *theVertexBuffer = NULL;

    if (theShape->klass->type == CP_CIRCLE_SHAPE)
        {
        cpFloat theRadius = cpCircleShapeGetRadius(theShape);
        theVertexBuffer = [CVertexBuffer vertexBufferWithCircleWithRadius:theRadius points:16];
        }
    else if (theShape->klass->type == CP_SEGMENT_SHAPE)
        {
        cpVect A = cpSegmentShapeGetA(theShape);
        cpVect B = cpSegmentShapeGetB(theShape);
        Vector2 v[] = {
            { A.x, A.y },
            { B.x, B.y },
            };
        theVertexBuffer = [[[CVertexBuffer alloc] initWithTarget:GL_ARRAY_BUFFER usage:GL_STATIC_DRAW bytes:v length:sizeof(v)] autorelease];
        }
    else if (theShape->klass->type == CP_POLY_SHAPE)
        {
        int theVertexCount = cpPolyShapeGetNumVerts(theShape);
        
        NSMutableData *theData = [NSMutableData dataWithLength:sizeof(Vector2) * (theVertexCount + 1)];
        Vector2 *V = theData.mutableBytes;
                
        for (int N = 0; N != theVertexCount; ++N)
            {
            cpVect theVector = cpPolyShapeGetVert(theShape, N);
            *V++ = (Vector2){ theVector.x, theVector.y };
            }

        cpVect theVector = cpPolyShapeGetVert(theShape, 0);
        *V++ = (Vector2){ theVector.x, theVector.y };

        theVertexBuffer = [[[CVertexBuffer alloc] initWithTarget:GL_ARRAY_BUFFER usage:GL_STATIC_DRAW data:theData] autorelease];
        }
    
    return(theVertexBuffer);
    }

@end
