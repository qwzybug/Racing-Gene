//
//  CMainWindowController.m
//  Racing Gene
//
//  Created by Jonathan Wight on 01/22/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CMainWindowController.h"

#import "CRendererView2.h"
#import "OpenGLTypes.h"
#import "CRendererOpenGLLayer.h"
#import "CTestRenderer.h"
#import "CSceneGraph.h"
#import "CSceneGraphRenderer.h"
#import "CGeometryNode.h"
#import "CVertexBuffer_FactoryExtensions.h"
#import "CShader.h"
#import "CProgram.h"
#import "CImageTextureLoader.h"
#import "CVertexBufferReference.h"
#import "CProgram_ConvenienceExtensions.h"
#import "CGameModel.h"
#import "CChipmunkBody.h"

@interface CMainWindowController ()
@property (readwrite, nonatomic, retain) CGameModel *model;
@end

@implementation CMainWindowController

@synthesize rendererView;
@synthesize model;

- (id)initWithWindow:(NSWindow *)window
    {
    if ((self = [super initWithWindow:window]))
        {
        }
    return self;
    }

- (void)dealloc
    {
    [super dealloc];
    }

- (void)windowDidLoad
    {
    [super windowDidLoad];
    }

- (void)awakeFromNib
    {
    __block CSceneGraphRenderer *theRenderer = [[[CSceneGraphRenderer alloc] init] autorelease];
    
    theRenderer.prepareBlock = ^(void) {

        self.model = [[[CGameModel alloc] init] autorelease];
        theRenderer.sceneGraph = self.model.sceneGraph;
    
       };
        
    theRenderer.preRenderBlock = ^ (void) {
        [self.model update];
        
        CGPoint thePosition = self.model.carBody.position;
        
        theRenderer.transform = Matrix4MakeTranslation(-thePosition.x, -thePosition.y, 1.0);
        
        };
    
    self.rendererView.rendererLayer.renderer = theRenderer;
    }

@end


// OLD BRICK CODE --- put into new class

//    theRenderer.prepareBlock = ^(void) {
//        CSceneGraph *theSceneGraph = [[[CSceneGraph alloc] init] autorelease];
//        
//        // #############################################################################################################
//
//        CProgram *theTextureProgram = [[[CProgram alloc] initWithFilename:@"Texture" attributeNames:[NSArray arrayWithObjects:@"vertex", @"color", @"texture", NULL] uniformNames:NULL] autorelease];
//
//        CVertexBuffer *theVertices = [CVertexBuffer vertexBufferWithRect:(CGRect){ -1, -1, 2, 2 }];
//        CVertexBuffer *theTextureVertexBuffer = [CVertexBuffer vertexBufferWithRect:(CGRect){ 0, 0, 1, 1 }];
//
//        // Colors
//        CVertexBuffer *theColors = [CVertexBuffer vertexBufferWithColors:[NSArray arrayWithObjects:[NSColor redColor], [NSColor greenColor], [NSColor blueColor], [NSColor whiteColor], NULL]];
//
//        CImageTextureLoader *theLoader = [[[CImageTextureLoader alloc] init] autorelease];
//        CTexture *theTexture = [theLoader textureWithImage:[NSImage imageNamed:@"Brick"] error:NULL];
//
//        // #############################################################################################################
//        
//        CGeometryNode *theBricksNode = [[[CGeometryNode alloc] init] autorelease];
//        theBricksNode.transform = Matrix4MakeScale(1, 1, 1);
//        theBricksNode.type = GL_TRIANGLE_STRIP;
//        theBricksNode.coordinatesBufferReference = [[[CVertexBufferReference alloc] initWithVertexBuffer:theVertices cellEncoding:@encode(Vector2) normalized:GL_FALSE stride:0] autorelease];
//        theBricksNode.colorsBufferReference = [[[CVertexBufferReference alloc] initWithVertexBuffer:theColors cellEncoding:@encode(Color4) normalized:GL_TRUE stride:0] autorelease];;
//        theBricksNode.textureCoordinatesBufferReference = [[[CVertexBufferReference alloc] initWithVertexBuffer:theTextureVertexBuffer cellEncoding:@encode(Vector2) normalized:GL_FALSE stride:0] autorelease];
//        theBricksNode.texture = theTexture;
//        theBricksNode.program = theTextureProgram;
//
//        theBricksNode.vertexBuffers = [NSSet setWithObjects:theVertices, theTextureVertexBuffer, theColors, NULL];
//
//        // #############################################################################################################
//
//        CProgram *theFlatProgram = [[[CProgram alloc] initWithFilename:@"Flat" attributeNames:[NSArray arrayWithObjects:@"vertex", @"color", @"texture", NULL] uniformNames:NULL] autorelease];
//
//
//        CVertexBuffer *theCircleCoordinates = [CVertexBuffer vertexBufferWithCircleWithRadius:0.5 points:30];
//
//        CGeometryNode *theCircleNode = [[[CGeometryNode alloc] init] autorelease];
//        theCircleNode.transform = Matrix4MakeScale(1, 1, 1);
//        theCircleNode.type = GL_LINE_STRIP;
//        theCircleNode.coordinatesBufferReference = [[[CVertexBufferReference alloc] initWithVertexBuffer:theCircleCoordinates cellEncoding:@encode(Vector2) normalized:GL_FALSE stride:0] autorelease];
//        theCircleNode.program = theFlatProgram;
//
//        theCircleNode.vertexBuffers = [NSSet setWithObjects:theCircleCoordinates, theTextureVertexBuffer, theColors, NULL];
//
//        // #############################################################################################################
//
//
//        theSceneGraph.nodes = [NSArray arrayWithObjects:
//            theBricksNode,
//            theCircleNode,
//            NULL];
//    
//        theRenderer.sceneGraph = theSceneGraph;
 