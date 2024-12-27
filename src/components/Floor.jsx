import { useTexture } from '@react-three/drei'
import { useRef } from 'react'

export default function Floor( props )
{

    const self = useRef()
    const matcap = useTexture( './textures/matcaps/7.jpg' )

    return (
    <mesh ref={ self } { ...props }>
        <boxGeometry
            args={[11,0.1,11]}
        />
        <meshMatcapMaterial matcap={ matcap } />
    </mesh>
  )
}