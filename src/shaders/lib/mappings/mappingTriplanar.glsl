// worldPos world space and regular normal

vec4 mappingTriplanar( sampler2D tex, vec3 worldPos, vec3 normal, float scale) 
{

    normal = normalize( normal );
    vec3 blend = abs(normal);
    blend /= (blend.x + blend.y + blend.z);
    
    vec2 uvX = worldPos.yz * scale;
    vec2 uvY = worldPos.zx * scale;
    vec2 uvZ = worldPos.xy * scale;
    
    vec4 xAxis = texture( tex, uvX );
    vec4 yAxis = texture( tex, uvY );
    vec4 zAxis = texture( tex, uvZ );
    
    return xAxis * blend.x + yAxis * blend.y + zAxis * blend.z;

}

// scale 1.0 sharpness 2.0

vec4 mappingTriplanar( sampler2D tex, vec3 worldPos, vec3 normal, float scale, float sharpness) 
{

    normal = normalize( normal );
    vec3 blend = abs(normal);
    blend = pow( blend, vec3( sharpness ) );

    blend /= (blend.x + blend.y + blend.z);
    
    vec2 uvX = worldPos.yz * scale;
    vec2 uvY = worldPos.zx * scale;
    vec2 uvZ = worldPos.xy * scale;
    
    vec4 xAxis = texture( tex, uvX );
    vec4 yAxis = texture( tex, uvY );
    vec4 zAxis = texture( tex, uvZ );
    
    return xAxis * blend.x + yAxis * blend.y + zAxis * blend.z;

}