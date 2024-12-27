
vec3 colorHueDegrees( vec3 inputColor, float offset ) 
{
    
    vec4 K = vec4( 0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0 );
    
    vec4 P = mix(vec4(inputColor.bg, K.wz), vec4(inputColor.gb, K.xy), 
                 step(inputColor.b, inputColor.g));
    
    vec4 Q = mix(vec4(P.xyw, inputColor.r), vec4(inputColor.r, P.yzx), 
                 step(P.x, inputColor.r));
    
    float D = Q.x - min(Q.w, Q.y);
    float E = 1e-10;
    
    vec3 hsv = vec3(
        abs(Q.z + (Q.w - Q.y) / (6.0 * D + E)),
        D / (Q.x + E),
        Q.x
    );
    
 
    float hue = hsv.x + offset / 360.0;
    
    hsv.x = (hue < 0.0) ? hue + 1.0 : 
            (hue > 1.0) ? hue - 1.0 : hue;
    
    vec4 K2 = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 P2 = abs(fract(hsv.xxx + K2.xyz) * 6.0 - K2.www);
    
    return hsv.z * mix(K2.xxx, clamp(P2 - K2.xxx, 0.0, 1.0), hsv.y);

}

void colorHueRadians( vec3 inputColor, float offset ) 
{

    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 P = mix(vec4(inputColor.bg, K.wz), vec4(inputColor.gb, K.xy), step(inputColor.b, inputColor.g));
    vec4 Q = mix(vec4(P.xyw, inputColor.r), vec4(inputColor.r, P.yzx), step(P.x, inputColor.r));
    
    float D = Q.x - min(Q.w, Q.y);
    float E = 1e-10;
    
    vec3 hsv = vec3(
        abs(Q.z + (Q.w - Q.y) / (6.0 * D + E)),
        D / (Q.x + E),
        Q.x
    );
    
    float hue = hsv.x + offset;
    
    hsv.x = (hue < 0.0) ? hue + 1.0 : (hue > 1.0) ? hue - 1.0 : hue;
    
    vec4 K2 = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 P2 = abs(fract(hsv.xxx + K2.xyz) * 6.0 - K2.www);
    
    return hsv.z * mix(K2.xxx, clamp(P2 - K2.xxx, 0.0, 1.0), hsv.y);
}