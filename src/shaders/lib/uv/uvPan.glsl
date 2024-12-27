/*
/*  uvPan moves the uv by time and a speed vector for the x & y axis seperately
/*  bool for ping poning the uv and texture wrapping in the shader for infinite tiling
*/

vec2 uvPan( vec2 uv, float time, vec2 speed, bool pingPong, bool wrap )
{

    vec2 offset = ( pingPong ) ? speed * abs( sin( time ) ) : speed * time;
    vec2 uvPanned = ( wrap ) ? fract( uv + offset ) : uv + offset;

    return uvPanned;

}