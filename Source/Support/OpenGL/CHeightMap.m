//
//  CHeightMap.m
//  Racing Genes
//
//  Created by Jonathan Wight on 09/07/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import "CHeightMap.h"

#import "CVertexBuffer.h"
#import "CMutableVertexBuffer.h"

@interface CHeightMap ()
//@property (readwrite, nonatomic, assign) GLushort indexCount;
@property (readwrite, nonatomic, retain) CVertexBuffer *indexBuffer;
//@property (readonly, nonatomic, assign) GLushort vertexCount;
@property (readwrite, nonatomic, retain) CVertexBuffer *vertexBuffer;
@property (readwrite, nonatomic, retain) CMutableVertexBuffer *colorBuffer;

- (void)setup;
@end

#pragma mark -

@implementation CHeightMap

@synthesize columns;
@synthesize rows;
@synthesize indexCount;
@synthesize indexBuffer;
@synthesize vertexCount;
@synthesize vertexBuffer;
@synthesize colorBuffer;

- (id)initWithColumns:(GLushort)inColumns rows:(GLushort)inRows;
{
if ((self = [super init]) != NULL)
    {
    columns = inColumns;
    rows = inRows;
    int theIndexCount = columns * (rows - 1) * 2 + rows * 2 - 3;
    NSAssert1(theIndexCount < 65536, @"OOPs %d is > 65536", theIndexCount);
    indexCount = theIndexCount;
    NSLog(@"ESTIMATED: %d", indexCount);
    
	GLuint numberOfVertices = (2*inColumns) * (inRows-1);
	GLuint numberOfDegenarateVertices = (inRows-2) * 2;
	indexCount = numberOfVertices + numberOfDegenarateVertices;
    
    [self setup];
    }
return(self);
}

- (void)dealloc
    {
    [vertexBuffer release];
    vertexBuffer = NULL;
    [colorBuffer release];
    colorBuffer = NULL;
    //
    [super dealloc];
    }

- (void)setup
    {
    NSLog(@"Calculated: %d", self.vertexCount);
    
    GLushort theWidth = self.columns;
    GLushort theHeight = self.rows;
    
    // TODO
    __block NSMutableData *theVertexData = [NSMutableData dataWithLength:sizeof(SHeightMapCell) * 65536];
    __block NSMutableData *theIndexData = [NSMutableData dataWithLength:sizeof(GLushort) * 65536];
    __block SHeightMapCell *theCells = (SHeightMapCell *)[theVertexData mutableBytes];
    __block GLushort *theIndices = (GLushort *)[theIndexData mutableBytes];
    __block NSMutableDictionary *theIndicesForCells = [NSMutableDictionary dictionary];
    __block GLushort N = 0;
    __block GLushort M = 0;

    void (^My_write)(GLfloat H, GLfloat V) = ^(GLfloat H, GLfloat V) { 
        SHeightMapCell theCell = {
            .vector = { H, V },
//            .color = { 0, 0, (float)H * 1.9, 255 }
            };
        NSValue *theValue = [NSValue valueWithBytes:&theCell objCType:@encode(SHeightMapCell)];
        NSNumber *theIndex = [theIndicesForCells objectForKey:theValue];
        if (theIndex == NULL)
            {
            theIndex = [NSNumber numberWithUnsignedInt:N];
            [theIndicesForCells setObject:theIndex forKey:theValue];
            theCells[N++] = theCell;
            }
    
        theIndices[M++] = [theIndex unsignedIntValue];
        };
    
    
    My_write(0, 0);
    My_write(0, 0);
    My_write(0, 1);
    
    for (GLushort Y = 0; Y != theHeight - 1; Y++)
        {
        GLushort X = 0;
        for (; X != theWidth - 1; ++X)
            {
            My_write(X + 1, Y);
            My_write(X + 1, Y + 1);
            }

        if (Y != theHeight - 2)
            {
            My_write(X, Y + 1);
//            My_write(X, Y + 2);
            My_write(0, Y + 1);
            My_write(0, Y + 1);
            My_write(0, Y + 2);
            }
        }

    NSLog(@"%d %d", M, N);

    theVertexData.length = N * sizeof(SHeightMapCell);
    vertexCount = N;
    indexCount = M;

    NSAssert(M == self.indexCount, @"OOPS");

    CVertexBuffer *theBuffer = [[[CVertexBuffer alloc] initWithTarget:GL_ARRAY_BUFFER usage:GL_STATIC_DRAW data:theVertexData] autorelease];
    self.vertexBuffer = theBuffer;

    CVertexBuffer *theIndexBuffer = [[[CVertexBuffer alloc] initWithTarget:GL_ELEMENT_ARRAY_BUFFER usage:GL_STATIC_DRAW data:theIndexData] autorelease];
    self.indexBuffer = theIndexBuffer;
    }

    
- (CMutableVertexBuffer *)colorBuffer
    {
    if (colorBuffer == NULL)
        {
        NSLog(@"%d", self.vertexCount);
        
        Color4 theRGBA = { 0, 0, 0, 255 };
        NSAssert(sizeof(theRGBA) == 4, @"Not 4 bytes!");
        NSMutableData *theData = [NSMutableData dataWithLength:sizeof(theRGBA) * self.vertexCount];
        memset_pattern4([theData mutableBytes], &theRGBA, [theData length]);
        CMutableVertexBuffer *theBuffer = [[[CMutableVertexBuffer alloc] initWithTarget:GL_ARRAY_BUFFER usage:GL_DYNAMIC_DRAW data:theData] autorelease];

        colorBuffer = [theBuffer retain];
        }
    return(colorBuffer);
    }

@end
