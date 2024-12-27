// Individual blend mode functions
vec3 blendNormal(vec3 base, vec3 blend) 
{
    return blend;
}

vec3 blendMultiply(vec3 base, vec3 blend) 
{
    return base * blend;
}

vec3 blendScreen(vec3 base, vec3 blend) 
{
    return 1.0 - (1.0 - base) * (1.0 - blend);
}

vec3 blendOverlay(vec3 base, vec3 blend) 
{
    return vec3(
        base.r < 0.5 ? (2.0 * base.r * blend.r) : (1.0 - 2.0 * (1.0 - base.r) * (1.0 - blend.r)),
        base.g < 0.5 ? (2.0 * base.g * blend.g) : (1.0 - 2.0 * (1.0 - base.g) * (1.0 - blend.g)),
        base.b < 0.5 ? (2.0 * base.b * blend.b) : (1.0 - 2.0 * (1.0 - base.b) * (1.0 - blend.b))
    );
}

vec3 blendDarken(vec3 base, vec3 blend) 
{
    return min(base, blend);
}

vec3 blendLighten(vec3 base, vec3 blend) 
{
    return max(base, blend);
}

vec3 blendColorDodge(vec3 base, vec3 blend) 
{
    return vec3(
        blend.r == 1.0 ? 1.0 : min(1.0, base.r / (1.0 - blend.r)),
        blend.g == 1.0 ? 1.0 : min(1.0, base.g / (1.0 - blend.g)),
        blend.b == 1.0 ? 1.0 : min(1.0, base.b / (1.0 - blend.b))
    );
}

vec3 blendColorBurn(vec3 base, vec3 blend) 
{
    return vec3(
        blend.r == 0.0 ? 0.0 : 1.0 - min(1.0, (1.0 - base.r) / blend.r),
        blend.g == 0.0 ? 0.0 : 1.0 - min(1.0, (1.0 - base.g) / blend.g),
        blend.b == 0.0 ? 0.0 : 1.0 - min(1.0, (1.0 - base.b) / blend.b)
    );
}

vec3 blendHardLight(vec3 base, vec3 blend) 
{
    return vec3(
        blend.r < 0.5 ? 2.0 * base.r * blend.r : 1.0 - 2.0 * (1.0 - base.r) * (1.0 - blend.r),
        blend.g < 0.5 ? 2.0 * base.g * blend.g : 1.0 - 2.0 * (1.0 - base.g) * (1.0 - blend.g),
        blend.b < 0.5 ? 2.0 * base.b * blend.b : 1.0 - 2.0 * (1.0 - base.b) * (1.0 - blend.b)
    );
}

vec3 blendSoftLight(vec3 base, vec3 blend) 
{
    return vec3(
        blend.r < 0.5 ? base.r - (1.0 - 2.0 * blend.r) * base.r * (1.0 - base.r) 
                     : base.r + (2.0 * blend.r - 1.0) * (sqrt(base.r) - base.r),
        blend.g < 0.5 ? base.g - (1.0 - 2.0 * blend.g) * base.g * (1.0 - base.g)
                     : base.g + (2.0 * blend.g - 1.0) * (sqrt(base.g) - base.g),
        blend.b < 0.5 ? base.b - (1.0 - 2.0 * blend.b) * base.b * (1.0 - base.b)
                     : base.b + (2.0 * blend.b - 1.0) * (sqrt(base.b) - base.b)
    );
}

vec3 blendDifference(vec3 base, vec3 blend) 
{
    return abs(base - blend);
}

vec3 blendExclusion(vec3 base, vec3 blend) 
{
    return base + blend - 2.0 * base * blend;
}

// Unified blend function that can use any blend mode
vec3 blend(vec3 base, vec3 blend, int mode) 
{
    switch (mode) 
    {
        case 0: return blendNormal(base, blend);
        case 1: return blendMultiply(base, blend);
        case 2: return blendScreen(base, blend);
        case 3: return blendOverlay(base, blend);
        case 4: return blendDarken(base, blend);
        case 5: return blendLighten(base, blend);
        case 6: return blendColorDodge(base, blend);
        case 7: return blendColorBurn(base, blend);
        case 8: return blendHardLight(base, blend);
        case 9: return blendSoftLight(base, blend);
        case 10: return blendDifference(base, blend);
        case 11: return blendExclusion(base, blend);
        default: return base; // Fallback to normal blend
    }

}