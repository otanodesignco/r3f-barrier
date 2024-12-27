float sampleHeight(sampler2D heightMap, vec2 uv, vec2 texelSize) 
{
    vec4 color = texture2D(heightMap, uv);
    // Convert color to grayscale
    return dot(color.rgb, vec3(0.299, 0.587, 0.114));
}

// Function to generate normal map from height map
vec3 normalFromTexture(sampler2D heightMap, vec2 uv, float strength) 
{
    vec2 texelSize = 1.0 / vec2(textureSize(heightMap, 0));
    
    // Sample neighboring heights using Sobel operator
    float tl = sampleHeight(heightMap, uv + vec2(-texelSize.x, -texelSize.y), texelSize);
    float t  = sampleHeight(heightMap, uv + vec2(0.0, -texelSize.y), texelSize);
    float tr = sampleHeight(heightMap, uv + vec2(texelSize.x, -texelSize.y), texelSize);
    float l  = sampleHeight(heightMap, uv + vec2(-texelSize.x, 0.0), texelSize);
    float r  = sampleHeight(heightMap, uv + vec2(texelSize.x, 0.0), texelSize);
    float bl = sampleHeight(heightMap, uv + vec2(-texelSize.x, texelSize.y), texelSize);
    float b  = sampleHeight(heightMap, uv + vec2(0.0, texelSize.y), texelSize);
    float br = sampleHeight(heightMap, uv + vec2(texelSize.x, texelSize.y), texelSize);
    
    // Sobel filters for x and y gradients
    float dx = (tr + 2.0 * r + br) - (tl + 2.0 * l + bl);
    float dy = (bl + 2.0 * b + br) - (tl + 2.0 * t + tr);
    
    // Construct normal vector
    vec3 normal = normalize(vec3(
        dx * strength,
        dy * strength,
        1.0
    ));
    
    // Transform from [-1,1] to [0,1] range
    return normal * 0.5 + 0.5;

}