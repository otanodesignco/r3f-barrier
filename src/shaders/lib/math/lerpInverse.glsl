float lerpInverse( float min, float max, float value ) 
{
   
    if ( min == max ) 
    {

        return 0.0;

    }

    return ( value - min ) / ( max - min );

}


vec2 lerpInverse( vec2 min, vec2 max, vec2 value ) 
{

    return vec2(
        lerpInverse(min.x, max.x, value.x),
        lerpInverse(min.y, max.y, value.y)
    );

}

vec3 lerpInverse( vec3 min, vec3 max, vec3 value ) 
{

    return vec3(
        lerpInverse(min.x, max.x, value.x),
        lerpInverse(min.y, max.y, value.y),
        lerpInverse(min.z, max.z, value.z)
    );

}

vec4 lerpInverse( vec4 min, vec4 max, vec4 value ) 
{

    return vec4(
        lerpInverse(min.x, max.x, value.x),
        lerpInverse(min.y, max.y, value.y),
        lerpInverse(min.z, max.z, value.z),
        lerpInverse(min.w, max.w, value.w)
    );

}