import { useEffect, useRef } from 'react'
import MeshSphereMaskMaterial from '../materials/MeshSphereMaskMaterial.jsx'
import { useControls } from 'leva'
import { useFrame } from '@react-three/fiber'
import { DoubleSide } from 'three'

export default function SphereMask( props ) 
{

    const self = useRef()

    const { transitionProgress } = useControls({
        transitionProgress:
        {
            value: 0,
            min: 0,
            max: 1,
            step: 0.01
        }
    })

    useEffect( () =>{

    },[])

    useFrame( ( state, delta ) =>
    {
        
    })

  return (
    <mesh ref={ self } {...props}>
        <planeGeometry args={[5, 5, 64, 64]} />
        <MeshSphereMaskMaterial
          side={ DoubleSide }
          transparent={ true }
        />
    </mesh>
  )
}
