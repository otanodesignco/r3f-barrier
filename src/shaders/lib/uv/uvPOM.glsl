// Parallax Occulusion uv maping

vec2 uvPOM( sampler2D heightMap, vec2 initialUV, vec3 viewDirTangent, float layerCount, float refinementSteps ) 
{

    float layerDepth = 1.0 / layerCount;

    vec3 P = vec3( initialUV, 0.0 );
    vec3 stepVec = viewDirTangent * layerDepth;

    float depth = texture( heightMap, P.xy ).r;

    while ( P.z < depth ) 
    {

        P += stepVec;
        depth = texture(heightMap, P.xy).r;

    }

    int i = 0;

    for ( i = 0; i < int( refinementSteps ); ++i ) 
    {
        stepVec *= 0.5;
        P -= stepVec;

        depth = texture( heightMap, P.xy ).r;

        if ( P.z > depth ) 
        {

            P += stepVec;

        }
    }

    return P.xy;

}

vec2 uvPOM( vec2 texCoords, vec3 viewDir, sampler2D heightMap, float heightScale ) 
{

    const float minLayers = 8.0;
    const float maxLayers = 32.0;
    
    float numLayers = mix( maxLayers, minLayers, abs( dot( vec3( 0.0, 0.0, 1.0 ), viewDir ) ) );
    
    float layerDepth = 1.0 / numLayers;
    float currentLayerDepth = 0.0;
    
    vec2 P = viewDir.xy * heightScale;
    vec2 deltaTexCoords = P / numLayers;
    
    vec2 currentTexCoords = texCoords;
    float currentDepthMapValue = texture( heightMap, currentTexCoords ).r;
    
    while ( currentLayerDepth < currentDepthMapValue ) 
    {

        currentTexCoords -= deltaTexCoords;
        currentDepthMapValue = texture( heightMap, currentTexCoords ).r;
        currentLayerDepth += layerDepth;

    }
    
    vec2 prevTexCoords = currentTexCoords + deltaTexCoords;
    float prevDepthMapValue = texture( heightMap, prevTexCoords ).r;
    float afterDepth = currentDepthMapValue - currentLayerDepth;
    float beforeDepth = prevDepthMapValue - ( currentLayerDepth - layerDepth );

    float weight = afterDepth / ( afterDepth - beforeDepth );
    
    vec2 finalTexCoords = mix( currentTexCoords, prevTexCoords, weight );
    
    return finalTexCoords;

}

vec2 uvPOM(
    vec2 texCoords,
    vec3 viewDir,
    sampler2D heightMap,
    float heightScale,
    float minLayers,
    float maxLayers
) {

    float numLayers = mix(maxLayers, minLayers, abs(dot(vec3(0.0, 0.0, 1.0), viewDir)));
    
    float layerDepth = 1.0 / numLayers;
    float currentLayerDepth = 0.0;
    
    vec2 P = viewDir.xy * heightScale;
    vec2 deltaTexCoords = P / numLayers;
    
    vec2 currentTexCoords = texCoords;
    float currentDepthMapValue = 1.0 - texture(heightMap, currentTexCoords).r;
    
    while(currentLayerDepth < currentDepthMapValue) 
    {
        
        currentTexCoords -= deltaTexCoords;
        
        currentDepthMapValue = 1.0 - texture(heightMap, currentTexCoords).r;
        
        currentLayerDepth += layerDepth;

    }
    
    vec2 prevTexCoords = currentTexCoords + deltaTexCoords;
    
    float afterDepth = currentDepthMapValue - currentLayerDepth;
    float beforeDepth = (1.0 - texture(heightMap, prevTexCoords).r) - 
                       (currentLayerDepth - layerDepth);
    
    float weight = afterDepth / (afterDepth - beforeDepth);
    vec2 finalTexCoords = mix(currentTexCoords, prevTexCoords, weight);
    
    if(finalTexCoords.x > 1.0 || finalTexCoords.y > 1.0 || 
       finalTexCoords.x < 0.0 || finalTexCoords.y < 0.0)
        discard;
    
    return finalTexCoords;

}