vec3 cartesianToSpherical(vec3 p) 
{
    float r = length(p);
    float theta = acos(p.y / r);        // Polar angle [0, π]
    float phi = atan(p.z, p.x);         // Azimuthal angle [-π, π]
    return vec3(r, theta, phi);
}


vec2 mappingPolar(vec3 position, float textureScale ) 
{
    vec3 spherical = cartesianToSpherical(position);
    vec2 uv = vec2(
        (spherical.z + 3.14159) / (2.0 * 3.14159),
        spherical.y / 3.14159
    );
    
    return uv * textureScale;
}


vec2 mappingCylinder( vec3 position, float textureScale ) 
{
    float theta = atan(position.z, position.x);
    float height = position.y;
    
    vec2 uv = vec2(
        (theta + 3.14159) / (2.0 * 3.14159),
        height
    );
    
    return uv * textureScale;

}

// Advanced polar mapping with pole fixing and seam handling
vec4 mappingPolarAdv( sampler2D diffuseMap, vec3 position, float polarSmoothing, bool fixSeams ) 
{
    vec2 uv = polarMapping(position);
    
    if (fixSeams) 
    {
        // Sample main texture
        vec4 color = texture2D(diffuseMap, uv);
        
        // Sample across the seam for blending
        vec2 uvSeam = vec2(fract(uv.x + 0.5), uv.y);
        vec4 colorSeam = texture2D(diffuseMap, uvSeam);
        
        // Calculate blend factor for seam
        float seamBlend = smoothstep(0.95, 1.0, uv.x) - smoothstep(0.0, 0.05, uv.x);
        color = mix(color, colorSeam, seamBlend);
        
        // Handle poles (prevent pinching)
        float poleBlend = smoothstep(0.0, polarSmoothing, uv.y) * 
                         smoothstep(1.0, 1.0 - polarSmoothing, uv.y);
        
        // Sample at different angles around poles
        vec4 poleColor = vec4(0.0);
        int numPoleSamples = 8;
        for (int i = 0; i < numPoleSamples; i++) {
            float angle = float(i) / float(numPoleSamples);
            vec2 poleUV = vec2(uv.x + angle, uv.y);
            poleColor += texture2D(diffuseMap, poleUV);
        }
        poleColor /= float(numPoleSamples);
        
        // Blend pole samples with main color
        color = mix(poleColor, color, poleBlend);
        
        return color;
    }
    
    return texture2D(diffuseMap, uv);

}
