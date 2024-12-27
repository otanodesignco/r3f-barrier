vec2 tileOffset( vec2 uv , vec2 tiling, vec2 offset, bool wrap )
{

    float test = 1.0;

    if( tiling.x < test || tiling.y < test )
    {

        tiling = vec2( 1.0 ); // cannot allow below 1.0 numbers

    }

    vec2 rtn = uv; // rtn return value
    rtn *= tiling; // tile uv
    rtn += offset; // offset to animate

    return ( wrap ) ? fract( rtn ) : rtn; // repeat texture infinitely

}