
vec3 unpackNormal(vec3 packedNormal) 
{
    return packedNormal * 2.0 - 1.0;
}

vec3 packNormal(vec3 normal) 
{
    return normal * 0.5 + 0.5;
}

vec3 normalBlend( vec3 normal1, vec3 normal2 )
{
    
    return vec3( normal1.rg + normal2.rg, normal1.b * normal2.b );

}

vec3 normalBlendReorient( vec3 normal1, vec3 normal2 )
{

    vec3 t = normal1.xyz + vec3( 0.0, 0.0, 1.0 );
    vec3 u = normal2.xyz * vec3( -1.0, -1.0, 1.0 );

    return ( t / t.z ) * dot( t, u ) - u;
    
}

vec3 normalBlend(
    vec3 normalMap1, 
    vec3 normalMap2, 
    float blendFactor, 
    int blendMode
) {
    
    vec3 normal1 = unpackNormal(normalMap1);
    vec3 normal2 = unpackNormal(normalMap2);

    vec3 blendedNormal;

    
    switch(blendMode) {
        case 0:
            
            blendedNormal = normalize(normal1 + normal2);
            break;
        
        case 1:
            
            blendedNormal = normalize(
                vec3(
                    normal1.x * (1.0 - blendFactor) + normal2.x * blendFactor,
                    normal1.y * (1.0 - blendFactor) + normal2.y * blendFactor,
                    normal1.z
                )
            );
            break;
        
        case 2:
            
            blendedNormal = normalize(
                vec3(
                    normal1.x + normal2.x,
                    normal1.y + normal2.y,
                    normal1.z + normal2.z
                )
            );
            break;
        
        case 3:
            
            vec3 t = normal1 + vec3(0, 0, 1);
            vec3 u = normal2 * vec3(-1, -1, 1);
            vec3 v = t * dot(t, u) / t.z - u;
            blendedNormal = normalize(v);
            break;
        
        case 4:
            
            blendedNormal = normalize(
                mix(normal1, normal2, blendFactor)
            );
            break;
        
        default:
            
            blendedNormal = normalize(normal1 + normal2);
        break;

    }

    return packNormal(blendedNormal);

}