vec3 calculateBarycentric() 
{
    vec3 bary;
    
    // Compute derivatives
    vec3 dpdx = dFdx(gl_FragCoord.xyz);
    vec3 dpdy = dFdy(gl_FragCoord.xyz);
    
    // Calculate areas of triangles formed by vectors
    float area = abs(dpdx.x * dpdy.y - dpdx.y * dpdy.x);
    
    bary.x = abs(gl_FragCoord.x * dpdy.y - gl_FragCoord.y * dpdy.x) / area;
    bary.y = abs(gl_FragCoord.y * dpdx.x - gl_FragCoord.x * dpdx.y) / area;
    bary.z = 1.0 - bary.x - bary.y;
    
    return bary;

}


vec4 wireframe(float thickness, vec4 edgeColor, vec4 fillColor) 
{
    vec3 bary = calculateBarycentric();
    
    // Find the minimum distance to an edge
    float minBary = min(min(bary.x, bary.y), bary.z);
    
    // Compute edge factor with anti-aliasing
    float edgeFactor = smoothstep(0.0, thickness, minBary);
    
    // Mix between edge color and fill color based on edge factor
    return mix(edgeColor, fillColor, edgeFactor);
}