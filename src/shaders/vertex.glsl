
out vec2 vUv;
out vec3 worldNormals;
out vec3 viewDirection;
out vec3 worldPosition;
out vec3 normals;

void main()
{
    vec4 normalsWorld = modelMatrix * vec4( normal, 0.0 );
    vec4 positionWorld = modelMatrix * vec4( position, 1.0 );
    vec3 directionView = cameraPosition - position;

    gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );

    vUv = uv;
    worldNormals = normalsWorld.xyz;
    viewDirection = directionView;
    worldPosition = positionWorld.xyz;
    normals = normal;

}