// unity saturate with overloads for vec2, vec3 & vec4 for convience

float saturate( float v )
{
    return clamp( v, 0.0, 1.0 );
}

vec2 saturate( vec2 v )
{
    return vec2( clamp( v.x, 0.0, 1.0 ), clamp( v.y, 0.0, 1.0 ) );
}

vec3 saturate( vec3 v )
{
    return vec3( clamp( v.x, 0.0, 1.0 ), clamp( v.y, 0.0, 1.0 ), clamp( v.z, 0.0, 1.0 ) );
}

vec4 saturate( vec4 v )
{
    return vec3( clamp( v.x, 0.0, 1.0 ), clamp( v.y, 0.0, 1.0 ), clamp( v.z, 0.0, 1.0 ), clamp( v.w, 0.0, 1.0 ) );
}