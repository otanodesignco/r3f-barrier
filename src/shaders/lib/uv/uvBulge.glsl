vec2 uvBulge(vec2 uv, vec2 center, float strength, float radius) 
{

    vec2 uvCenter = uv - center;
    
    float middle = length( uvCenter );
    
    float factor = max(0.0, 1.0 - middle / radius );
    
    float bulgeAmount = factor * strength;
    
    float distortion = 1.0 + bulgeAmount;
    
    return center + uvCenter * distortion;

}