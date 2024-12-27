vec3 colorBanding( vec3 color, float bands, int method )
{

    // method refers to round 0, ceil 1, floor 2
    vec3 banding = vec3( 0.0 );

    switch( method )
    {
        case 0:
            banding = round( color * bands ) / bands;
        break;

        case 1:
            banding = ceil( color * bands ) / bands;
        break;

        case 2:
            banding = floor( color * bands ) / bands;
        break;

        default:
            banding = round( color * bands ) / bands;
        break;
        
    }
    

    return banding;

}

vec4 colorBanding( vec4 color, float bands, int method )
{

    // method refers to round 0, ceil 1, floor 2
    vec4 banding = vec4( 0.0 );
    float alpha = color.a;

    switch( method )
    {
        case 0:
            banding = round( color * bands ) / bands;
        break;

        case 1:
            banding = ceil( color * bands ) / bands;
        break;

        case 2:
            banding = floor( color * bands ) / bands;
        break;

        default:
            banding = round( color * bands ) / bands;
        break;
        
    }
    

    return vec4( banding.rgb, alpha );

}