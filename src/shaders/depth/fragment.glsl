#include <packing>
uniform float uTime;
uniform sampler2D uDepthTexture;
uniform float uCamNear;
uniform float uCamFar;
uniform vec2 uResolution;
uniform sampler2D uNoiseTexture;
uniform sampler2D uDotsTexture;

in vec2 vUv;
in vec3 worldPosition;
in vec3 vWorldNormal;
in vec3 viewDirection;
in vec3 normals;
in vec4 screenPosition;
in vec4 clipSpace;

#include ../lib/util/readDepth.glsl
#include ../lib/lighting/lightingRim.glsl
#include ../lib/uv/uvScale.glsl
#include ../lib/uv/uvPan.glsl

void main()
{

    vec2 uv = vUv;
    float time = uTime;

    vec2 uvScaled = uvScale( uv, vec2( 6.0 ) );
    vec2 uvScaled2 = uvScale( uv, vec2( 3.0 ) );
    vec2 uvWorld = worldPosition.xy;
    vec2 uvPanned = uvPan( uvScaled2, time, vec2( 0.0, -0.3 ), false, false );
    // uvWorld *= 0.5 + 0.5;
    

    float fresnel = lightingRim( vWorldNormal, viewDirection, 2.0, true );

    float dots = texture( uDotsTexture, uvScaled ).r;
    float noise = texture( uNoiseTexture, uvPanned ).r;
    float noiseAdjust = pow( noise, 3.0 );
    dots *= noiseAdjust;

    vec2 uvDepth = gl_FragCoord.xy / uResolution;
    float d = texture( uDepthTexture, uvDepth ).r;
    d = linearizeDepth( d, uCamNear, uCamFar );
    float z = gl_FragCoord.z;
    z = linearizeDepth( z, uCamNear, uCamFar );
    float diff = abs( z - d );
    float threshold = 0.002;

    float diffff = d - 0.5;

    float mixFactor = clamp( diff / threshold, 0.0, 1.0 );

    vec4 colorIntersection = mix( vec4( 0.82, 0.57, 0.55, 1.0 ), vec4( 0.0 ), mixFactor );

    vec3 colorFresnel = vec3( 0.77, 0.35, 0.32 ) * 1.5;
    vec3 colorDots = vec3( 0.38, 0.74, 0.78 ) * 1.2;
    colorDots *= dots;
    colorFresnel *= fresnel;

    

    vec4 colorFinal = vec4( colorDots, 1.0 );
    //colorFinal.rgb += colorFresnel;

    gl_FragColor = colorFinal + colorIntersection;

    gl_FragColor = mix( gl_FragColor, vec4( colorFresnel, 1.0 ), fresnel );
    
    #include <tonemapping_fragment>
    #include <colorspace_fragment>
    
}