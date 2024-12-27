import { shaderMaterial, useTexture } from '@react-three/drei'
import { extend, useFrame } from '@react-three/fiber'
import React, { useRef } from 'react'
import vertex from '../shaders/vertex.glsl'
import fragment from '../shaders/fragment.glsl'
import { RepeatWrapping, Vector2, Color } from 'three'

export default function MeshSphereMaskMaterial( {
    texture ='./textures/noise/noiseVoronoi.png',
    ...props
} ) 
{
    const self = useRef()

    const noise = useTexture( texture )
    noise.wrapS = RepeatWrapping
    noise.wrapT = RepeatWrapping

    console.log( props )

    const uniforms =
    {
        uTime: 0,
        uNoiseTexture: noise,
    }

    useFrame( ( state, delta ) =>
    {
        self.current.uniforms.uTime.value += delta
    })

    const MeshSphereMaskMaterial = shaderMaterial( uniforms, vertex, fragment )
    extend( { MeshSphereMaskMaterial } )

    return (
        <meshSphereMaskMaterial
            key={ MeshSphereMaskMaterial.key }
            ref={ self }
            {...props}
        />
    )
}