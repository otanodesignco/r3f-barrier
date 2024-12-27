// vertex function to glitch vertices
vec3 wobble( float time, float speed, float size, vec3 position, float randomOffset )
{
    vec3 vertices = position;
    randomOffset *= 0.001;
    float distortion = sin( time * speed + vertices.y * 20. ) * (size * 0.01 );
    float wobble = step( uRandomSeed, randomOffset );

    vertices.x += distortion * wobble;

    return vertices;
}