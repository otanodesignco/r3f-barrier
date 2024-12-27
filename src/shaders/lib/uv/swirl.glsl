float swirl( vec2 uv, float size, int arms )
{
	float angle = atan( -uv.y + 0.5, uv.x - 0.5 ) ;
	float len = length( uv - vec2( 0.5, 0.5 ) );
	
	float swirled = sin( len * size + angle * float( arms ) );
	
	return swirled * 0.5 + 0.5;

}