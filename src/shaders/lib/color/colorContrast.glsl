vec3 colorContrast( vec3 color, float contrast )
{

    float midPoint = pow( 0.5, 2.2 );

    return ( color - midPoint ) * contrast + midPoint;
    
}