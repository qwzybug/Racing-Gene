/*
 *  OpenGLTypes.h
 *  Racing Gene
 *
 *  Created by Jonathan Wight on 09/07/10.
 *  Copyright 2010 toxicsoftware.com. All rights reserved.
 *
 */
 
#import "OpenGLTypes.h"

// Matrix4 code based on code from http://sunflow.sourceforge.net/

const Matrix4 Matrix4Identity = {
    1.0, 0.0, 0.0, 0.0,
    0.0, 1.0, 0.0, 0.0,
    0.0, 0.0, 1.0, 0.0,
    0.0, 0.0, 0.0, 1.0 };

BOOL Matrix4IsIdentity(Matrix4 t)
    {
    return(Matrix4EqualToTransform(t, Matrix4Identity));
    }

BOOL Matrix4EqualToTransform(Matrix4 a, Matrix4 b)
    {
    return(memcmp(&a, &b, sizeof(Matrix4)) == 0);
    }
    
Matrix4 Matrix4MakeTranslation(GLfloat tx, GLfloat ty, GLfloat tz)
    {
    const Matrix4 theMatrix = {
        1.0, 0.0, 0.0, 0.0,
        0.0, 1.0, 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0,
        tx, ty, tz, 1.0 };
    return(theMatrix);
    }
    
Matrix4 Matrix4MakeScale(GLfloat sx, GLfloat sy, GLfloat sz)
    {
    const Matrix4 theMatrix = {
        sx, 0.0, 0.0, 0.0,
        0.0, sy, 0.0, 0.0,
        0.0, 0.0, sz, 0.0,
        0.0, 0.0, 0.0, 1.0 };
    return(theMatrix);
    }
    
Matrix4 Matrix4MakeRotation(GLfloat angle, GLfloat x, GLfloat y, GLfloat z)
    {
    Matrix4 m = {};
    float invLen = 1.0 / sqrtf(x * x + y * y + z * z);
    x *= invLen;
    y *= invLen;
    z *= invLen;
    float s = sinf(angle);
    float c = cosf(angle);
    float t = 1.0 - c;
    m.m00 = t * x * x + c;
    m.m11 = t * y * y + c;
    m.m22 = t * z * z + c;
    float txy = t * x * y;
    float sz = s * z;
    m.m01 = txy - sz;
    m.m10 = txy + sz;
    float txz = t * x * z;
    float sy = s * y;
    m.m02 = txz + sy;
    m.m20 = txz - sy;
    float tyz = t * y * z;
    float sx = s * x;
    m.m12 = tyz - sx;
    m.m21 = tyz + sx;
    m.m33 = 1.0;
    return m;
    }
    
Matrix4 Matrix4Translate(Matrix4 t, GLfloat tx, GLfloat ty, GLfloat tz)
    {
    return(Matrix4Concat(t, Matrix4MakeTranslation(tx, ty, tz)));
    }
    
Matrix4 Matrix4Scale(Matrix4 t, GLfloat sx, GLfloat sy, GLfloat sz)
    {
    return(Matrix4Concat(t, Matrix4MakeScale(sx, sy, sz)));
    }
    
Matrix4 Matrix4Rotate(Matrix4 t, GLfloat angle, GLfloat x, GLfloat y, GLfloat z)
    {
    return(Matrix4Concat(t, Matrix4MakeRotation(angle, x, y, z)));
    }
    
Matrix4 Matrix4Concat(Matrix4 a, Matrix4 m)
    {
    Matrix4 theMatrix = {
        a.m00 * m.m00 + a.m01 * m.m10 + a.m02 * m.m20 + a.m03 * m.m30,
        a.m00 * m.m01 + a.m01 * m.m11 + a.m02 * m.m21 + a.m03 * m.m31,
        a.m00 * m.m02 + a.m01 * m.m12 + a.m02 * m.m22 + a.m03 * m.m32,
        a.m00 * m.m03 + a.m01 * m.m13 + a.m02 * m.m23 + a.m03 * m.m33,

        a.m10 * m.m00 + a.m11 * m.m10 + a.m12 * m.m20 + a.m13 * m.m30,
        a.m10 * m.m01 + a.m11 * m.m11 + a.m12 * m.m21 + a.m13 * m.m31,
        a.m10 * m.m02 + a.m11 * m.m12 + a.m12 * m.m22 + a.m13 * m.m32,
        a.m10 * m.m03 + a.m11 * m.m13 + a.m12 * m.m23 + a.m13 * m.m33,

        a.m20 * m.m00 + a.m21 * m.m10 + a.m22 * m.m20 + a.m23 * m.m30,
        a.m20 * m.m01 + a.m21 * m.m11 + a.m22 * m.m21 + a.m23 * m.m31,
        a.m20 * m.m02 + a.m21 * m.m12 + a.m22 * m.m22 + a.m23 * m.m32,
        a.m20 * m.m03 + a.m21 * m.m13 + a.m22 * m.m23 + a.m23 * m.m33,

        a.m30 * m.m00 + a.m31 * m.m10 + a.m32 * m.m20 + a.m33 * m.m30,
        a.m30 * m.m01 + a.m31 * m.m11 + a.m32 * m.m21 + a.m33 * m.m31,
        a.m30 * m.m02 + a.m31 * m.m12 + a.m32 * m.m22 + a.m33 * m.m32,
        a.m30 * m.m03 + a.m31 * m.m13 + a.m32 * m.m23 + a.m33 * m.m33,
        };
    return(theMatrix);
    }
    
Matrix4 Matrix4Invert(Matrix4 t)
    {
    float A0 = t.m00 * t.m11 - t.m01 * t.m10;
    float A1 = t.m00 * t.m12 - t.m02 * t.m10;
    float A2 = t.m00 * t.m13 - t.m03 * t.m10;
    float A3 = t.m01 * t.m12 - t.m02 * t.m11;
    float A4 = t.m01 * t.m13 - t.m03 * t.m11;
    float A5 = t.m02 * t.m13 - t.m03 * t.m12;

    float B0 = t.m20 * t.m31 - t.m21 * t.m30;
    float B1 = t.m20 * t.m32 - t.m22 * t.m30;
    float B2 = t.m20 * t.m33 - t.m23 * t.m30;
    float B3 = t.m21 * t.m32 - t.m22 * t.m31;
    float B4 = t.m21 * t.m33 - t.m23 * t.m31;
    float B5 = t.m22 * t.m33 - t.m23 * t.m32;

    float det = A0 * B5 - A1 * B4 + A2 * B3 + A3 * B2 - A4 * B1 + A5 * B0;
    NSCAssert(fabs(det) >= 1e-12f, @"Not invertable");
    float invDet = 1.0 / det;
    Matrix4 m = {
        (+t.m11 * B5 - t.m12 * B4 + t.m13 * B3) * invDet,
        (-t.m10 * B5 + t.m12 * B2 - t.m13 * B1) * invDet,
        (+t.m10 * B4 - t.m11 * B2 + t.m13 * B0) * invDet,
        (-t.m10 * B3 + t.m11 * B1 - t.m12 * B0) * invDet,
        (-t.m01 * B5 + t.m02 * B4 - t.m03 * B3) * invDet,
        (+t.m00 * B5 - t.m02 * B2 + t.m03 * B1) * invDet,
        (-t.m00 * B4 + t.m01 * B2 - t.m03 * B0) * invDet,
        (+t.m00 * B3 - t.m01 * B1 + t.m02 * B0) * invDet,
        (+t.m31 * A5 - t.m32 * A4 + t.m33 * A3) * invDet,
        (-t.m30 * A5 + t.m32 * A2 - t.m33 * A1) * invDet,
        (+t.m30 * A4 - t.m31 * A2 + t.m33 * A0) * invDet,
        (-t.m30 * A3 + t.m31 * A1 - t.m32 * A0) * invDet,
        (-t.m21 * A5 + t.m22 * A4 - t.m23 * A3) * invDet,
        (+t.m20 * A5 - t.m22 * A2 + t.m23 * A1) * invDet,
        (-t.m20 * A4 + t.m21 * A2 - t.m23 * A0) * invDet,
        (+t.m20 * A3 - t.m21 * A1 + t.m22 * A0) * invDet,
        };
    return(m);
    }
    
NSString *NSStringFromMatrix4(Matrix4 t)
    {
    return([NSString stringWithFormat:@"{ %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f }",
        t.m00, t.m01, t.m02, t.m03, 
        t.m10, t.m11, t.m12, t.m13, 
        t.m20, t.m21, t.m22, t.m23, 
        t.m30, t.m31, t.m32, t.m33]);
    }
