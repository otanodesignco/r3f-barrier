float banding( float displacemnt, float bands, int method )
{
    float band = 0.0;

    switch( method )
    {
        case 0:
            float band = round( displacemnt * bands ) / bands;
        break;

        case 1:
            float band = ceil( displacemnt * bands ) / bands;
        break;

        case 2:
            float band = floor( displacemnt * bands ) / bands;
        break;

        default:
            float band = round( displacemnt * bands ) / bands;
        break;
        
    }

    return band;

}