vec3 normalReconstructZ(vec2 normals )
 {

    float reconstructZ = sqrt( 1.0 - clamp( dot( normals.xy, normals.xy ), 0.0, 1.0 ) );
    vec3 normalVector = vec3( normals.x, normals.y, reconstructZ);
    
    return normalize(normalVector);

}