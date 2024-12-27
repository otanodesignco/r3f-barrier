vec3 colorSaturation( vec3 color, float saturation )
{

    float luminance = dot( color, vec3( 0.299, 0.587, 0.114 ) );
    
    vec3 grayscale = vec3( luminance );

    return mix( grayscale, color, 1.0 + saturation );

}