float lightingNoiseRim( vec3 normals, vec3 direction, float noise, float density, bool clamped )
{

    float noiseOffset = pow( noise, density );

    float rimCalc = 1.0 - dot( normalize( normals ), normalize( direction ) );
    float rimRtn = ( clamped ) ? clamp( rimCalc, 0.0, 1.0 ) : rimCalc;

    return pow( rimRtn , noiseOffset );

}