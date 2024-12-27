uniform float uTime;
uniform sampler2D uNoiseTexture;

in vec2 vUv;
in vec3 worldNormals;
in vec3 viewDirection;
in vec3 worldPosition;
in vec3 normals;

#include ./lib/uv/sphereMask.glsl
#include ./lib/uv/gradientMask.glsl

void main()
{

    vec2 uv = vUv;

    float time = uTime;

    float mask = sphereMask( uv, vec2( 0.5 ), 0.5, 0.8 );

    vec3 gradientMask = vec3( gradientMask( uv, vec2( 0.9, 0.00001 ), 0, true ) );


    vec3 color = vec3( 0.8, uv );

    vec4 colorFinal = vec4( gradientMask, 1.0 );


    gl_FragColor = colorFinal;

    #include <tonemapping_fragment>
    #include <colorspace_fragment>

}