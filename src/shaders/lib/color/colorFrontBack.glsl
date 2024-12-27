// set color based on it's face. utility function
vec3 colorFrontBack( vec3 color1, vec3 color2 )
{

    return ( gl_FrontFacing ) ? color1 : color2;
    
}