float posterize( float value, float steps )
{

    return floor( value / ( 1.0 / steps ) ) * ( 1.0 / steps );

}