//
//  Shader.vsh
//  Racing Genes
//
//  Created by Jonathan Wight on 09/05/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//


attribute vec4 vertex;
attribute vec4 color;

varying vec4 colorVarying;

uniform mat4 transform;

void main()
    {
    colorVarying = vec4(1.0, 0.0, 0.0, 1.0);
    gl_Position = transform * vertex;
    }
