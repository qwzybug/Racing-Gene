//
//  Noise.h
//  Racing Gene
//
//  Created by Jonathan Wight on 02/01/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#include <sys/types.h>

extern double Linear_Interpolate(double a, double b, double x);
extern double Interpolate(double a, double b, double x);
extern double Noise_1(int32_t x);
extern double SmoothedNoise_1(double x);
extern double InterpolatedNoise_1(double x);
extern double PerlinNoise_1D(double x);
 