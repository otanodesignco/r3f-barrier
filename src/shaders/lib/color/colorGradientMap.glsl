/*
* example usage is to create a noise as a float and turn it into a color and apply a gradient image
*/

vec4 colorGradientMap( vec4 color, sampler2D gradientMap, float intensity )
{

    float luminance = dot( color.rgb, vec3( 0.3, 0.59, 0.11 ) );
    float colorAlpha = color.a; // preserve original colors alpha 
    vec4 colorGradient = texture( gradientMap, vec2( luminance, 0.0 ) );

    vec3 colorMaped = mix( color.rbg, colorGradient.rgb, intensity );
    vec4 colorOut = vec4( colorMaped, colorAlpha );

    return colorOut;

}