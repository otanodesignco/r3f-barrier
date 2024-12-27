vec2 fishEye( vec2 uv, vec2 center, float strength, vec2 offset)
{
    
    vec2 delta = uv - center;
    float delta2 = dot(delta.xy, delta.xy);
    float delta4 = delta2 * delta2;
    vec2 delta_offset = delta4 * strength;

    return uv + delta * delta_offset + offset;

}

vec2 fishEye( vec2 uv, float strength ) 
{
    
    vec2 center = vec2(0.5);
    vec2 delta = uv - center;
    float distance = length(delta);

    float distortion = 1.0 + (distance * strength);
    vec2 distortedUV = center + delta / distortion;

    return distortedUV;
    
}