import { shaderMaterial, useDepthBuffer, useFBO, useTexture } from '@react-three/drei'
import { extend, useFrame, useThree } from '@react-three/fiber'
import React, { useRef } from 'react'
import vertex from '../shaders/depth/vertex.glsl'
import fragment from '../shaders/depth/fragment.glsl'
import { RepeatWrapping, Vector2, Color, DoubleSide, AdditiveBlending } from 'three'

export default function MeshIntersectionMaterial( 
{
    texture ='./textures/noise/noiseValueSoft.png',
    ...props
} ) 
{
    const self = useRef()

    const dpr = Math.min( window.devicePixelRatio, 2)
    const { camera } = useThree()
    const noise = useTexture( texture );
    const textureDots = useTexture( './textures/tiles/dots.png' )
    textureDots.wrapS = RepeatWrapping;
    textureDots.wrapT = RepeatWrapping;
    noise.wrapS = RepeatWrapping;
    noise.wrapT = RepeatWrapping;

    const uniforms =
    {
        uTime: 0,
        uNoiseTexture: noise,
        uDotsTexture: textureDots,
        uResolution: new Vector2( window.innerWidth * dpr, window.innerHeight * dpr ),
        uDepthTexture: null,
        uCamNear: camera.near,
        uCamFar: camera.far,
    }

    useFrame( ( state, delta ) =>
    {

        self.current.uniforms.uTime.value += delta

    })

    const MeshIntersectionMaterial = shaderMaterial( uniforms, vertex, fragment )
    extend( { MeshIntersectionMaterial } )

    return (
        <meshIntersectionMaterial
            key={ MeshIntersectionMaterial.key }
            ref={ self }
            {...props}
            transparent={ true }
            blending={ AdditiveBlending }
        />
    )

}
