// diffuse lighting

float lightLambert( vec3 normals, vec3 direction )
{
    return max( dot( normalize( normals ), normalize( direction ) ), 0.0 );
}

float lightLambert( vec3 normals, vec3 direction, vec2 smoothing )
{

    float diffuse = max( dot( normalize( normals ), normalize( direction ) ), 0.0 );

    return smoothstep( smoothing.x, smoothing.y, diffuse );

}

float lightLambert( vec3 normals, vec3 direction, float smoothing )
{

    float diffuse = max( dot( normalize( normals ), normalize( direction ) ), 0.0 );

    return diffuse * smoothing;
    
}