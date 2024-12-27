float gradientMask( vec2 uv, vec2 startSoftness, int direction, bool angled ) 
{

    float dir;

    switch( direction )
    {
        case 0:
            dir = ( angled ) ? 0.5 * ( uv.x + uv.y ) : uv.x;
        break;
        case 1:
            dir = ( angled ) ? 0.5 * (- uv.x + uv.y ) : uv.y;
        break;
        case 2:
            dir = ( angled ) ? 0.5 * ( -uv.x + -uv.y ) : -uv.x;
        break;
        case 3:
            dir = ( angled ) ? 0.5 * ( uv.x + -uv.y ) : -uv.y;
        break;
        default:
            dir = ( angled ) ? 0.5 * ( uv.x + uv.y ) : uv.x;
        break;
    }

    float mask;

    // if both are equal hard edge
    if( startSoftness.x == startSoftness.y || startSoftness.y == 0.0 )
    {
        mask = step( startSoftness.x, dir );
    }
    else
    {
        mask = step( startSoftness.x, dir ) * smoothstep( startSoftness.x, 1.0 + startSoftness.y, dir );
    }

    return mask;

}
