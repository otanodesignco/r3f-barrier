vec2 uvStretch( vec2 uv, vec2 strength )
{
    return uv / strength;
}

vec2 uvStretch( vec2 uv, vec2 strength, bool wrap )
{
    vec2 scaledUV = uv / strength;

    return ( wrap ) ? fract( scaledUV ) : scaledUV;
}