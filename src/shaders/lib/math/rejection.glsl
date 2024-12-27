vec3 rejection( vec3 a, vec3 b )
{

    return a - ( b * dot( a, b ) / dot( b, b ) );

}

vec4 rejection( vec4 a, vec4 b )
{

    return a - ( b * dot( a, b ) / dot( b, b ) );
    
}