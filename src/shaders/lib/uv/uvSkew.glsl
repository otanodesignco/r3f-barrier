vec2 uvSkew( vec2 uv, vec2 skewFactor, bool matrix )
{

    if( matrix )
    {

        mat2 skewMat = mat2( 
        1.0, skewFactor.x,
        skewFactor.y, 1.0 );
    
        vec2 uvCentered = uv - 0.5;

        vec2 uvSkewed = skewMat * uvCentered;

        return uvSkewed + 0.5;

    }
    
    vec2 skewedUV = uv;
    skewedUV.x += uv.y * skewFactor.x;
    skewedUV.y += uv.x * skewFactor.y;

    return skewedUV;

}
