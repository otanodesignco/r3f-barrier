float waveNoise( float value, vec2 minMax )
{
    
    float sinIn = sin( value );
    float sinInOffset = sin( value + 1.0 );
    float randomno =  fract(sin(( sinIn - sinInOffset ) * ( 12.9898 + 78.233 ) ) * 43758.5453 );
    float noise = lerp( minMax.x, minMax.y, randomno) ;

    return sinIn + noise;

}