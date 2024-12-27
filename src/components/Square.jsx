import { useTexture } from '@react-three/drei'
import { useEffect, useRef } from 'react'
import { Vector3 } from 'three'

export default function Square( props ) 
{

    const self = useRef()
    const matcap = useTexture( './textures/matcaps/7.jpg' )


  return (
    <mesh ref={ self } { ...props }>
        <boxGeometry
            args={[3,3,3]}
        />
        <meshMatcapMaterial matcap={ matcap } />
    </mesh>
  )

}
