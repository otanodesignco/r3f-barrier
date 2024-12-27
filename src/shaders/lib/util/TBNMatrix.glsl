// create faux tbn matrix for use in parallax mapping and occulusion parallax mapping

mat3 TBNMatrix( vec3 N ) 
{

    vec3 T;
    vec3 B;
    
    if (abs(N.z) > 0.999999) {
        T = vec3(1.0, 0.0, 0.0);
        B = vec3(0.0, 1.0, 0.0);
    } else {
        float a = 1.0 / (1.0 + N.z);
        float b = -N.x * N.y * a;
        T = vec3(1.0 - N.x * N.x * a, b, -N.x);
        B = vec3(b, 1.0 - N.y * N.y * a, -N.y);
    }
    
    return mat3(T, B, N);

}