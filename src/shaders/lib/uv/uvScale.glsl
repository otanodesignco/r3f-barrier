vec2 uvScale(vec2 uv, vec2 scaleFactor )
{

	mat2 scale = mat2( vec2(  scaleFactor.x,  0.0 ), vec2( 0.0,  scaleFactor.y ) );
	
	uv -= 0.5;
	uv = uv * scale;
	uv += 0.5;

	return uv;

}