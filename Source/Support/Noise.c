//
//  Noise.m
//  Racing Gene
//
//  Created by Jonathan Wight on 02/01/11.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import "Noise.h"

double Linear_Interpolate(double a, double b, double x)
    {
	return(a * (1.0 - x) + b * x);
    }

double Interpolate(double a, double b, double x)
    {
    return(Linear_Interpolate(a,b,x));
    }

double Noise_1(int32_t x)
    {
    x = (x << 13) ^ x;
    return(1.0 - ((x * (x * x * 15731 + 789221) + 1376312589) & 0x7fffffff) / 1073741824.0);    
    }

double SmoothedNoise_1(double x)
    {
    return(Noise_1(x)/2 + Noise_1(x-1)/4 + Noise_1(x+1) / 4);
    }

double InterpolatedNoise_1(double x)
    {
    int32_t integer_X    = (int)x;
    double fractional_X = x - integer_X;

    double v1 = SmoothedNoise_1(integer_X);
    double v2 = SmoothedNoise_1(integer_X + 1);

    return(Interpolate(v1 , v2 , fractional_X));
    }


#define persistence 1
#define Number_Of_Octaves 8

double PerlinNoise_1D(double x)
    {
    double total = 0.0;
    double p = persistence;
    int n = Number_Of_Octaves - 1;

    for (int i = 0; i != n; ++i)
        {
        double frequency = pow(2, i);
        double amplitude = pow(p, i);
        total = total + InterpolatedNoise_1(x * frequency) * amplitude;
        }
    return(total);
    }
