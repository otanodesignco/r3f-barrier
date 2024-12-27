float waveTriangle( float value )
{

    return 2.0 * abs( 2.0 * ( value - floor( 0.5 + value ) ) ) - 1.0;

}