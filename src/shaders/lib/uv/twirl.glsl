vec2 twirl(vec2 uv, vec2 center, float strength, vec2 offset)
{
    vec2 delta = uv - center;
    float angle = strength * length(delta);
    float x = cos(angle) * delta.x - sin(angle) * delta.y;
    float y = sin(angle) * delta.x + cos(angle) * delta.y;
    return vec2(x + center.x + offset.x, y + center.y + offset.y);
}

vec2 twirl(vec2 uv, vec2 center, float angle, float radius) 
{
    // Calculate the vector from the center to the current UV coordinate
    vec2 toUV = uv - center;
    
    // Calculate the distance from the center to the current UV coordinate
    float distance = length(toUV);
    
    // Only apply the twirl effect within the specified radius
    if (distance < radius) 
    {
        // Calculate the angle of the vector from the center to the UV coordinate
        float originalAngle = atan(toUV.y, toUV.x);
        
        // Apply the twirl effect by adding the angle parameter to the original angle
        float newAngle = originalAngle + (distance / radius) * angle;
        
        // Convert the new angle and distance back to UV coordinates
        toUV = vec2(cos(newAngle), sin(newAngle)) * distance;
    }
    
    // Return the modified UV coordinates
    return toUV + center;

}