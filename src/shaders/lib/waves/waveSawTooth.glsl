float waveSawTooth( float value )
{
    
    return 2.0 * ( value - floor( 0.5 + value ) );

}