
out vec2 vUv;
out vec3 worldPosition;
out vec3 worldNormal;
out vec3 viewDirection;
out vec3 normals;

void main()
{

    vec4 worldPos = modelMatrix * vec4( position, 1.0 );
    vec4 worldNorm = modelMatrix * vec4( normal, 0.0 );

    gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );

    vUv = uv;
    worldPosition = worldPos.xyz;
    worldNormal = worldNorm.xyz;
    viewDirection = cameraPosition - worldPosition.xyz;
    normals = normal;
    
}