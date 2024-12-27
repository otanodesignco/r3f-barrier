uniform float uTime;

in vec2 vUv;
in vec3 worldPosition;
in vec3 worldNormal;
in vec3 viewDirection;
in vec3 normals;

void main()
{

    vec2 uv = vUv;
    vec2 uvWorld = worldPosition.xy;
    // uvWorld *= 0.5 + 0.5;
    float time = uTime;

    gl_FragColor = vec4( uv, 0.8, 1.0 );
    
    #include <tonemapping_fragment>
    #include <colorspace_fragment>
    
}