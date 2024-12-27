vec3 unpackNormalRGB(vec3 rgb) 
{
    // Convert from [0,1] to [-1,1] range
    return 2.0 * rgb - 1.0;
    
}

// Unpack normals stored in RG/xy format with reconstructed z
// This format is more memory efficient as it only needs 2 channels
vec3 unpackNormalRG(vec2 rg) 
{
    // RG components are in [0,1] range, need to convert to [-1,1]
    vec2 xy = 2.0 * rg - 1.0;
    
    // Reconstruct z component assuming unit length
    // z = sqrt(1 - x^2 - y^2)
    float z = sqrt(1.0 - dot(xy, xy));
    
    return vec3(xy, z);
}

// Unpack normals stored in octahedron encoding
// This is a more sophisticated format that maintains better precision
vec2 signNotZero(vec2 v) 
{
    return vec2(v.x >= 0.0 ? 1.0 : -1.0, 
                v.y >= 0.0 ? 1.0 : -1.0);
}

vec3 unpackNormalOctahedron(vec2 encoded) 
{
    vec2 nxy = encoded * 2.0 - 1.0;
    
    // Recover z component
    vec3 n = vec3(nxy.x, nxy.y, 1.0 - abs(nxy.x) - abs(nxy.y));
    
    // Handle the negative z hemisphere
    float t = max(-n.z, 0.0);
    n.xy += n.xy >= 0.0 ? -t : t;
    
    return normalize(n);

}