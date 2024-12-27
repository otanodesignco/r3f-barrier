// parallax mapping

vec2 uvPM( sampler2D heightMap, vec2 uv, vec3 viewDirTangent, float heightScale ) 
{

    float height = texture( heightMap, uv ).r;

    vec2 parallaxOffset = viewDirTangent.xy * ( height * heightScale );

    return uv - parallaxOffset;

}

vec2 uvPM( sampler2D heightMap, vec2 uv, vec3 viewDirTangent, float heightScale, bool clipEdges ) 
{

    if( clipEdges )
    {
        if( uv.x > 1.0 || uv.y > 1.0 || uv.x < 0.0 || uv.y < 0.0 ) discard;
    }

    float height = texture( heightMap, uv ).r;

    vec2 parallaxOffset = viewDirTangent.xy * ( height * heightScale );

    return uv - parallaxOffset;

}


vec2 uvPM( sampler2D heightMap, vec2 texCoords, vec3 viewDir, float heightScale, float minLayers, float maxLayers ) 
{
    
    float numLayers = mix(maxLayers, minLayers, abs(dot(vec3(0.0, 0.0, 1.0), viewDir)));
    
    float layerDepth = 1.0 / numLayers;
    float currentLayerDepth = 0.0;
    
    vec2 P = viewDir.xy * heightScale;
    vec2 deltaTexCoords = P / numLayers;
    
    vec2 currentTexCoords = texCoords;
    float currentDepthMapValue = 1.0 - texture( heightMap, currentTexCoords ).r;
    
    while( currentLayerDepth < currentDepthMapValue ) 
    {
    
        currentTexCoords -= deltaTexCoords;
        
        currentDepthMapValue = 1.0 - texture( heightMap, currentTexCoords ).r;
        
        currentLayerDepth += layerDepth;

    }
    
    vec2 prevTexCoords = currentTexCoords + deltaTexCoords;
    
    float afterDepth = currentDepthMapValue - currentLayerDepth;
    float beforeDepth = ( 1.0 - texture( heightMap, prevTexCoords ).r ) - currentLayerDepth + layerDepth;
    
    float weight = afterDepth / ( afterDepth - beforeDepth );
    vec2 finalTexCoords = prevTexCoords * weight + currentTexCoords * ( 1.0 - weight );
    
    return finalTexCoords;

}

vec2 uvPM( sampler2D heightMap, vec2 texCoords, vec3 viewDir, float heightScale, float minLayers, float maxLayers, bool clipEdges ) 
{

    if( clipEdges )
    {
        if( texCoords.x > 1.0 || texCoords.y > 1.0 || texCoords.x < 0.0 || texCoords.y < 0.0 ) discard;
    }
    
    float numLayers = mix(maxLayers, minLayers, abs(dot(vec3(0.0, 0.0, 1.0), viewDir)));
    
    float layerDepth = 1.0 / numLayers;
    float currentLayerDepth = 0.0;
    
    vec2 P = viewDir.xy * heightScale;
    vec2 deltaTexCoords = P / numLayers;
    
    vec2 currentTexCoords = texCoords;
    float currentDepthMapValue = 1.0 - texture( heightMap, currentTexCoords ).r;
    
    while( currentLayerDepth < currentDepthMapValue ) 
    {
    
        currentTexCoords -= deltaTexCoords;
        
        currentDepthMapValue = 1.0 - texture( heightMap, currentTexCoords ).r;
        
        currentLayerDepth += layerDepth;

    }
    
    vec2 prevTexCoords = currentTexCoords + deltaTexCoords;
    
    float afterDepth = currentDepthMapValue - currentLayerDepth;
    float beforeDepth = ( 1.0 - texture( heightMap, prevTexCoords ).r ) - currentLayerDepth + layerDepth;
    
    float weight = afterDepth / ( afterDepth - beforeDepth );
    vec2 finalTexCoords = prevTexCoords * weight + currentTexCoords * ( 1.0 - weight );
    
    return finalTexCoords;

}