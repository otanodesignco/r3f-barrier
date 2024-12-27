
import { useRef } from "react"
import Floor from "./components/Floor.jsx"
import Orb from "./components/Orb.jsx"
import { NearestFilter } from "three"
import { useFrame } from "@react-three/fiber"
import { useFBO } from "@react-three/drei"
import Square from "./components/Square.jsx"
import gsap from "gsap"

export default function Experience()
{

    const orbRef = useRef()

   const depthTarget = useFBO( window.innerWidth, window.innerHeight,{
    depth: true,
    stencilBuffer: false,
    minFilter: NearestFilter,
    magFilter: NearestFilter,
   })

    useFrame( ( state, delta ) =>
    {
        const { gl, camera, scene } = state

        orbRef.current.visible = false

        gl.setRenderTarget( depthTarget )
        gl.render( scene, camera )

        orbRef.current.material.uniforms.uDepthTexture.value = depthTarget.depthTexture

        gl.setRenderTarget( null )

        const scale = 1 + Math.sin( state.clock.elapsedTime * 0.7 ) * 0.2

        orbRef.current.scale.set( scale, scale, scale )

        orbRef.current.visible = true
        gl.render( scene, camera )

    } )


    return(
        <group>
            <Orb ref={ orbRef } />
            <Square position={ [2.5,0.7, 0] } scale={ 0.5 } />
            <Square position={ [-2.2,0.7, 1.1] } scale={ 0.5 } />
            <Floor />
        </group>
    )
    
}