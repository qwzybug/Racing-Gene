/*
 *  OpenGLTypes.h
 *  Racing Gene
 *
 *  Created by Jonathan Wight on 09/07/10.
 *  Copyright 2010 toxicsoftware.com. All rights reserved.
 *
 */
 
#import "OpenGLIncludes.h"

typedef struct Vector2 {
    GLfloat x, y;
    } Vector2;
    
typedef struct Vector3 {
    GLfloat x, y, z;
    } Vector3;

typedef struct Vector4 {
    GLfloat x, y, z, w;
    } Vector4;
    
typedef struct Color4 {
    GLubyte r,g,b,a;
    } Color4;

typedef struct SIntPoint {
    GLint x, y;
    } SIntPoint;

typedef struct SIntSize {
    GLint width, height;
    } SIntSize;


typedef struct Matrix4 {
    GLfloat m00, m01, m02, m03;
    GLfloat m10, m11, m12, m13;
    GLfloat m20, m21, m22, m23;
    GLfloat m30, m31, m32, m33;
} Matrix4;

extern const Matrix4 Matrix4Identity;

extern BOOL Matrix4IsIdentity(Matrix4 t);
extern BOOL Matrix4EqualToTransform(Matrix4 a, Matrix4 b);
extern Matrix4 Matrix4MakeTranslation(GLfloat tx, GLfloat ty, GLfloat tz);
extern Matrix4 Matrix4MakeScale(GLfloat sx, GLfloat sy, GLfloat sz);
extern Matrix4 Matrix4MakeRotation(GLfloat angle, GLfloat x, GLfloat y, GLfloat z);
extern Matrix4 Matrix4Translate(Matrix4 t, GLfloat tx, GLfloat ty, GLfloat tz);
extern Matrix4 Matrix4Scale(Matrix4 t, GLfloat sx, GLfloat sy, GLfloat sz);
extern Matrix4 Matrix4Rotate(Matrix4 t, GLfloat angle, GLfloat x, GLfloat y, GLfloat z);
extern Matrix4 Matrix4Concat(Matrix4 a, Matrix4 b);
extern Matrix4 Matrix4Invert(Matrix4 t);
extern NSString *NSStringFromMatrix4(Matrix4 t);

#define AssertOpenGLNoError_() NSAssert(glGetError() == GL_NO_ERROR, @"Code entered with existing OGL error")