vec3 projection( vec3 a, vec3 b )
{

    return b * dot( a, b ) / dot( b, b );

}

vec4 projection( vec4 a, vec4 b )
{

    return b * dot( a, b ) / dot( b, b );
    
}