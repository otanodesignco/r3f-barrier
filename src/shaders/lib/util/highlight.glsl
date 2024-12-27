// creates a highlight flash
float highlight( float shineSize, float direction, float speed, float time )
{

     return step( 1.0 - shineSize * 0.5, 0.5 + 0.5 * sin( direction + time * speed ) );

}