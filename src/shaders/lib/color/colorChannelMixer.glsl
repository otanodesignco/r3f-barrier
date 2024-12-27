vec3 colorChannelMixer( vec3 color, vec3 r, vec3 g, vec3 b )
{

    return vec3(    dot( color, r ),
                    dot( color, g ),
                    dot( color, b ) );

}

vec3 colorChannelMixer( vec3 inputColor, vec3 redMix, vec3 greenMix, vec3 blueMix, float brightness, float contrast )
{
    
    mat3 mixMatrix = mat3(
        redMix,
        greenMix,
        blueMix
    );
    
    
    vec3 mixedColor = mixMatrix * inputColor;
    
    mixedColor = max( vec3( 0.0 ), mixedColor * contrast + brightness );
    
    return mixedColor;

}