// creates a blinking that can be used with a color to blink the color's alpha
float blinking( float speed, float time )
{

    return 0.5 * 0.5 + sin( uTime * speed );
    
}