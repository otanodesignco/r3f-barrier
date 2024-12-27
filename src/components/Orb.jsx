/*
Auto-generated by: https://github.com/pmndrs/gltfjsx
*/

import React, { forwardRef, useRef } from 'react'
import { useGLTF } from '@react-three/drei'
import MeshIntersectionMaterial from '../materials/MeshIntersectionMaterial.jsx'

export default forwardRef( function Orb( props , ref ) 
{

    const self = ref

  return (
        <mesh ref={ self }>
            <icosahedronGeometry args={[ 3, 7 ]} />
            <MeshIntersectionMaterial
              
            />
        </mesh>
  )

})

useGLTF.preload('./models/orb.glb')