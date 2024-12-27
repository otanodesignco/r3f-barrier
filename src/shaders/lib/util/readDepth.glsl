// return depth to view-z

float readDepth( sampler2D depthTexture, vec2 uv, float near, float far, int cameraType, int viewType )
{

    float depth = texture( depthTexture, uv ).r;

    float viewZ = 0.0;
    float z = 0.0;

    switch( cameraType )
    {
        case 0: // default is 0 perspective
            viewZ = ( near * far ) / ( ( far - near ) * depth - far );
        break;

        case 1: // orthoganal
            viewZ =  depth * ( near - far ) - near;
        break;

        default: // perspective
            viewZ = ( near * far ) / ( ( far - near ) * depth - far );
        break;

    }

    // get view output type
    switch( viewType )
    {
        case 0: // orthoganal depth
            z = ( viewZ + near ) / ( near - far );
        break;

        case 1: // perspective depth
            z = ( ( near + viewZ ) * far ) / ( ( far - near ) * viewZ );
        break;

        default:
            z = ( viewZ + near ) / ( near - far );
        break;
    }

    return z;

}
// based on threejs example
float readDepth( sampler2D depthTexture, vec2 uv, float near, float far )
{

    float depth = texture( depthTexture, uv ).r;

    float viewZ = ( near * far ) / ( ( far - near ) * depth - far ); // perspective to viewZ
    float z = ( viewZ + near ) / ( near - far ); // viewz to orthoganal depth

    return z;
    
}

float readDepth( sampler2D depthTexture, vec2 uv, float near, float far, int cameraType )
{

    float depth = texture( depthTexture, uv ).r;

    float viewZ;

    switch( cameraType )
    {
        case 0: // default is 0 perspective
            viewZ = ( near * far ) / ( ( far - near ) * depth - far );
        break;

        case 1: // orthoganal
            viewZ =  depth * ( near - far ) - near;
        break;

        default: // perspective
            viewZ = ( near * far ) / ( ( far - near ) * depth - far );
        break;

    }

    return viewZ;

}

float toLinearDepth( float z, float near, float far )
{

    return ( 2.0 * near * far ) / ( far + near - ( 2.0 * z - 1.0 ) * ( far - near ) );

}

float toLinearDepth( float z, float near, float far, bool inRange, bool norm )
{

    z = ( inRange) ? z : 2.0 * z - 1.0;

    float depthLinear = ( !norm ) ? ( 2.0 * near * far ) / ( far + near - ( 2.0 * z - 1.0 ) * ( far - near ) ) : ( 2.0 * near * far ) / ( far + near - ( 2.0 * z - 1.0 ) * ( far - near ) ) / far;

    return depthLinear;

}
// 0 is perspective and 1 is orthographic
float depthToViewZ( float depth, float near, float far, int cameraType )
{
    float viewZ = 1.0;

    switch( cameraType )
    {

        case 0:
            viewZ = ( near * far ) / ( ( far - near ) * depth - far );
        break;

        case 1:
            viewZ = depth * ( near - far ) - near;
        break;

        default:
            viewZ = ( near * far ) / ( ( far - near ) * depth - far );
        break;

    }

    return viewZ;

}
// 0 is perspective and 1 is orthographic
float viewzToDepth( float viewZ, float near, float far, int cameraType )
{

    float depth = 1.0;

    switch( cameraType )
    {
        case 0:
            depth = ( ( near + viewZ ) * far ) / ( ( far - near ) * viewZ );
        break;

        case 1:
            depth = ( viewZ + near ) / ( near - far );
        break;

        default:
            depth = ( ( near + viewZ ) * far ) / ( ( far - near ) * viewZ );
        break;

    }

    return depth;

}

float linearEyeDepth(float rawDepth, float near, float far )
{
    return 1.0 / ( ( far - near ) * rawDepth / ( near * far ) + 1.0 / far );
}

// screen Position should be gl_FragCoord or clipspace postion, projectionMatrix * modelViewMatrix * vec4( position, 1.0 )
float unityDepth( sampler2D textureDepth, vec4 screenPosition, float near, float far )
{

    return (2.0 * near * far) / ( far + near - texture( textureDepth, screenPosition.xy / screenPosition.w ).r * ( far - near ) );

}

float depthToProj( float z, float near, float far )
{

    float ndc = 2.0 * z - 1.0;

    return -( 2.0 * far * near ) / ( ndc * ( far - near ) - far - near );

}

float linearizeDepth( float z, float near, float far )
{

    float ndc = 2.0 * z - 1.0;
    float eye = ( 2.0 * far * near ) / (( far + near ) - ndc * ( far - near ) );
    float linearDepth = ( eye - near ) / ( far - near );

    return linearDepth;

}

float linearZDepth( float depth, float near, float far )
{

    float z = depth * 2.0 - 1.0;
    return ( 2.0 * near * far ) / ( far + near - z * ( far - near ) );
    
}
