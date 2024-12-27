vec3 colorInvert( vec3 color ) 
{

    return vec3( 1.0 - color.r, 1.0 - color.g, 1.0 - color.b );

}

vec4 colorInvert( vec4 color ) 
{

    return vec4( 1.0 - color.rgb, color.a );

}

vec3 colorInvert2( vec3 color ) 
{
    
    return vec3( 1.0 - ( 0.299 * color.r + 0.587 * color.g + 0.114 * color.b ) );

}