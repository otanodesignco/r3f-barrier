vec3 normalStrength( vec3 normal, float strength ) 
{

    return vec3( normal.rg * strength, mix( 1.0, normal.b, clamp( strength, 0.0, 1.0 ) ) );

}