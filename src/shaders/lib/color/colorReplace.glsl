#include ./math/lerp.glsl
#include ./util/saturate.glsl

vec3 colorReplace( vec3 color, vec3 colorFrom, vec3 colorTo, float range, float fuzziness )
{

    float dist = distance( colorFrom, color );
    return lerp( colorTo, color, saturate( ( dist - range ) / max( fuzziness, 1e-5f ) ) );
    
}