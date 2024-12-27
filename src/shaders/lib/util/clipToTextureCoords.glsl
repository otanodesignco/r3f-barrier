vec2 clipToTextureCoords( vec4 clipSpaceCoords )
{
    vec2 NDC = clipSpaceCoords.xy / clipSpaceCoords.w;

    vec2 uv = NDC / 2.0 + 1.0;

    return uv;
}