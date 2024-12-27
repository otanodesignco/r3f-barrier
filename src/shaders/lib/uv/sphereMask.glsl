float sphereMask(vec2 uv, vec2 center, float radius, float hardness) 
{

    float dist = length(uv - center);
    
    float falloff = 1.0 - hardness;
    
    float mask = 1.0 - smoothstep( radius * (1.0 - falloff), radius, dist );
    
    return clamp( mask, 0.0, 1.0 );

}