//
//  CLandscape.m
//  Racing Gene
//
//  Created by Jonathan Wight on 02/01/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "CLandscape.h"

#import "Noise.h"

@interface CLandscape ()
@end

@implementation CLandscape

@synthesize heightValues;

- (id)init
    {
    if ((self = [super init]) != NULL)
        {
        heightValues = [[NSMutableArray alloc] init];
        for (int N = 0; N != 100; ++N)
            {
            [heightValues addObject:[NSNumber numberWithDouble:0]];
            }
        }
    return(self);
    }

- (void)dealloc
    {
    [heightValues release];
    heightValues = NULL;
    //
    [super dealloc];
    }

- (void)update
    {
    float dx = 0.05f;
    float dy = 0.01f;
    float amplitude = 100.0f;

    float yoff = 0; // TODO
    // Increment y ('time')
    yoff += dy;

    float xoff = yoff; // Option #2

    for (int i = 0; i < [heightValues count]; i++)
        {
        double yValue = (2 * PerlinNoise_1D(xoff) - 1.0) * amplitude;    // Option #2
        
        [heightValues replaceObjectAtIndex:i withObject:[NSNumber numberWithDouble:yValue]];
        
        xoff += dx;
        }
    }

//int xspacing = 8;   // How far apart should each horizontal location be spaced
//int w;              // Width of entire wave
//
//float yoff = 0.0f;        // 2nd dimension of perlin noise
//float[] yvalues;          // Using an array to store height values for the wave (not entirely necessary)
//
//void setup() {
//  size(200,200);
//  frameRate(30);
//  colorMode(RGB,255,255,255,100);
//  smooth();
//  w = width+16;
//  yvalues = new float[w/xspacing];
//}
//
//void draw() {
//  background(0);
//  calcWave();
//  renderWave();
//
//}
//
//void calcWave() {
//  float dx = 0.05f;
//  float dy = 0.01f;
//  float amplitude = 100.0f;
//
//  // Increment y ('time')
//  yoff += dy;
//
//  //float xoff = 0.0;  // Option #1
//  float xoff = yoff; // Option #2
//
//  for (int i = 0; i < yvalues.length; i++) {
//    // Using 2D noise function
//    //yvalues[i] = (2*noise(xoff,yoff)-1)*amplitude; // Option #1
//    // Using 1D noise function
//    yvalues[i] = (2*noise(xoff)-1)*amplitude;    // Option #2
//    xoff+=dx;
//  }
//
//}


@end
