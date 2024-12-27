vec2 uvRM(vec2 texCoords, vec3 viewDir)
 {
    const float minLayers = 8.0;
    const float maxLayers = 32.0;
    float numLayers = mix(maxLayers, minLayers, abs(dot(vec3(0, 0, 1), viewDir)));
    float layerDepth = 1.0 / numLayers;
    float currentLayerDepth = 0.0;
    
    // Calculate ray step size and initial texture coordinate offset
    vec2 P = viewDir.xy / viewDir.z * heightScale;
    vec2 deltaTexCoords = P / numLayers;
    
    vec2 currentTexCoords = texCoords;
    float currentDepthMapValue = texture(heightMap, currentTexCoords).r;
    
    // Linear search
    while(currentLayerDepth < currentDepthMapValue) {
        currentTexCoords -= deltaTexCoords;
        currentDepthMapValue = texture(heightMap, currentTexCoords).r;
        currentLayerDepth += layerDepth;
        
        if(currentTexCoords.x > 1.0 || currentTexCoords.y > 1.0 || 
           currentTexCoords.x < 0.0 || currentTexCoords.y < 0.0) {
            return texCoords;
        }
    }
    
    // Binary search refinement
    vec2 prevTexCoords = currentTexCoords + deltaTexCoords;
    float prevLayerDepth = currentLayerDepth - layerDepth;
    
    for(int i = 0; i < 5; i++) {
        deltaTexCoords *= 0.5;
        layerDepth *= 0.5;
        
        currentDepthMapValue = texture(heightMap, currentTexCoords).r;
        
        if(currentLayerDepth > currentDepthMapValue) {
            currentTexCoords += deltaTexCoords;
            currentLayerDepth -= layerDepth;
        } else {
            currentTexCoords -= deltaTexCoords;
            currentLayerDepth += layerDepth;
        }
    }
    
    return currentTexCoords;

}

vec2 uvRMSimple(vec2 texCoords, vec3 viewDir) 
{
    const float numSteps = 8.0;
    const float precision = 0.05;
    
    // Calculate step size and view ray in texture space
    float currentHeight = 0.0;
    vec2 deltaTexCoords = viewDir.xy * heightScale / (viewDir.z * numSteps);
    vec2 currentTexCoords = texCoords;
    
    // Linear search
    float heightFromTexture = texture(heightMap, currentTexCoords).r;
    while(currentHeight < 1.0 && heightFromTexture < currentHeight) {
        currentTexCoords -= deltaTexCoords;
        heightFromTexture = texture(heightMap, currentTexCoords).r;
        currentHeight += 1.0 / numSteps;
        
        if(currentTexCoords.x > 1.0 || currentTexCoords.y > 1.0 || 
           currentTexCoords.x < 0.0 || currentTexCoords.y < 0.0) {
            return texCoords;
        }
    }
    
    // Interpolate for smoothness
    vec2 prevTexCoords = currentTexCoords + deltaTexCoords;
    float nextHeight = heightFromTexture - currentHeight;
    float prevHeight = texture(heightMap, prevTexCoords).r - (currentHeight - 1.0/numSteps);
    
    float weight = nextHeight / (nextHeight - prevHeight);
    return mix(currentTexCoords, prevTexCoords, weight);
}