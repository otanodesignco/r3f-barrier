vec2 uvPolar( vec2 uv )
{

    float pi = 3.1416;
    vec2 mappedUV = uv * 2.0 - 1.0;
    vec2 polarUV = vec2( atan( mappedUV.y, mappedUV.x ) / pi / 2.0 + 0.5, length( mappedUV ) );

    return polarUV;

}

vec2 uvPolar(vec2 uv, vec2 center, float zoom, float repeat)
{

    float pi = 3.1416;
	vec2 dir = uv - center;
	float radius = length(dir) * 2.0;
	float angle = atan( dir.y, dir.x ) * 1.0 / ( pi * 2.0 );
	return mod(vec2( radius * zoom,  angle * repeat ), 1.0 );

}

vec2 uvPolar(vec2 uv, vec2 center, float radius) 
{
    float pi = 3.14159;

    vec2 uvCenter = uv - center;
    
    float angle = atan( uvCenter.y, uvCenter.x );
    
    float dist = length( uvCenter );
    
    float correctedDist = dist / radius;
    
    return vec2( angle / (2.0 * pi ), correctedDist );

}

vec2 uvPolar( vec2 uv, vec2 multiplier, vec2 offset )
{

    float pi = 3.14159;
    float pi2 = pi / 2.0;

    vec2 centerUV = uv - 0.5;
    float distToCenter = length( centerUV );
    float angle = atan( centerUV.y, centerUV.x );
    vec2 polarUV = vec2( angle + pi / pi2, distToCenter );
    polarUV *= multiplier;
    polarUV.x += offset.x;
    polarUV.y += offset.y;

    return polarUV;
}