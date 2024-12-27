
int getDominantAxis(vec3 normal) 
{
    vec3 absNormal = abs(normal);
    if (absNormal.x > absNormal.y && absNormal.x > absNormal.z) {
        return 0; // x axis
    } else if (absNormal.y > absNormal.z) {
        return 1; // y axis
    }
    return 2; // z axis
}


vec2 getAxisUV(vec3 position, int axis) 
{
    switch(axis) 
    {
        case 0: // x axis - use yz
            return position.yz;
        case 1: // y axis - use xz
            return position.xz;
        default: // z axis - use xy
            return position.xy;
    }

}

// Get texture direction signs for proper orientation
vec2 getAxisSigns(vec3 normal, int axis)
 {
    vec2 signs = vec2(1.0);

    switch(axis) 
    {
        case 0: // x axis
            signs.x = sign(normal.x);
            break;
        case 1: // y axis
            signs.y = sign(normal.y);
            break;
        case 2: // z axis
            signs.x = -sign(normal.z);
            break;
    }

    return signs;

}

vec4 mappingBox(vec3 worldPos, vec3 normal)
 {
    // Scale the world position
    worldPos *= textureScale;
    
    // Get dominant axis
    int dominantAxis = getDominantAxis(normal);
    
    // Get UV coordinates for the dominant axis
    vec2 uv = getAxisUV(worldPos, dominantAxis);
    
    // Apply sign corrections for proper orientation
    vec2 signs = getAxisSigns(normal, dominantAxis);
    uv *= signs;
    
    // Sample texture
    return texture2D(diffuseMap, uv);
    
}

// Version with smooth transitions between faces
vec4 mappingBox(vec3 worldPos, vec3 normal, float smoothness) 
{
    // Scale the world position
    worldPos *= textureScale;
    
    // Calculate weights for each axis based on normal
    vec3 weights = pow(abs(normal), vec3(smoothness));
    weights /= dot(weights, vec3(1.0));
    
    // Sample texture for each axis
    vec4 xAxis = texture2D(diffuseMap, worldPos.yz * sign(normal.x));
    vec4 yAxis = texture2D(diffuseMap, worldPos.xz * vec2(1.0, sign(normal.y)));
    vec4 zAxis = texture2D(diffuseMap, worldPos.xy * vec2(-sign(normal.z), 1.0));
    
    // Blend samples using weights
    return xAxis * weights.x + yAxis * weights.y + zAxis * weights.z;

}