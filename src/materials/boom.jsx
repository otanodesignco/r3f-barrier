import * as THREE from 'three';
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls';

class IntersectionGradientDemo {
    constructor() {
        // Scene setup
        this.scene = new THREE.Scene();
        this.camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
        this.renderer = new THREE.WebGLRenderer();
        this.renderer.setSize(window.innerWidth, window.innerHeight);
        document.body.appendChild(this.renderer.domElement);

        // Orbit controls for interactive view
        this.controls = new OrbitControls(this.camera, this.renderer.domElement);

        // Render target with depth texture
        this.renderTarget = new THREE.WebGLRenderTarget(window.innerWidth, window.innerHeight, {
            minFilter: THREE.LinearFilter,
            magFilter: THREE.LinearFilter,
            format: THREE.RGBAFormat,
            depthTexture: new THREE.DepthTexture(
                window.innerWidth, 
                window.innerHeight, 
                THREE.UnsignedIntType
            )
        });

        // Create scene objects
        this.setupScene();

        // Intersection shader material
        this.intersectionMaterial = this.createIntersectionMaterial();

        // Camera positioning
        this.camera.position.z = 5;
    }

    setupScene() {
        // First mesh
        this.mesh1 = new THREE.Mesh(
            new THREE.TorusKnotGeometry(1, 0.3, 100, 16),
            new THREE.MeshStandardMaterial({ color: 0xff0000, transparent: true, opacity: 0.5 })
        );
        this.scene.add(this.mesh1);

        // Second mesh
        this.mesh2 = new THREE.Mesh(
            new THREE.TorusGeometry(1.5, 0.2, 16, 100),
            new THREE.MeshStandardMaterial({ color: 0x00ff00, transparent: true, opacity: 0.5 })
        );
        this.scene.add(this.mesh2);

        // Add lighting
        const light1 = new THREE.PointLight(0xffffff, 1, 100);
        light1.position.set(5, 5, 5);
        this.scene.add(light1);

        const light2 = new THREE.PointLight(0xffffff, 1, 100);
        light2.position.set(-5, -5, -5);
        this.scene.add(light2);
    }

    createIntersectionMaterial() {
        return new THREE.ShaderMaterial({
            uniforms: {
                depthTexture: { value: this.renderTarget.depthTexture },
                near: { value: this.camera.near },
                far: { value: this.camera.far },
                intersectionColor: { value: new THREE.Color(1, 1, 0) },
                intersectionWidth: { value: 0.05 } // Gradient width
            },
            vertexShader: `
                varying vec2 vUv;
                varying vec4 vProjectedPos;
                
                void main() {
                    vUv = uv;
                    vProjectedPos = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
                    gl_Position = vProjectedPos;
                }
            `,
            fragmentShader: `
                uniform sampler2D depthTexture;
                uniform float near;
                uniform float far;
                uniform vec3 intersectionColor;
                uniform float intersectionWidth;
                
                varying vec2 vUv;
                varying vec4 vProjectedPos;

                // Linearize depth for more accurate comparison
                float linearizeDepth(float depth) {
                    float z = depth * 2.0 - 1.0;
                    return (2.0 * near * far) / (far + near - z * (far - near));
                }

                void main() {
                    // Sample depth texture
                    float sceneDepth = texture2D(depthTexture, vUv).r;
                    
                    // Convert to linear depth
                    float linearSceneDepth = linearizeDepth(sceneDepth) / far;
                    
                    // Current fragment's depth
                    float fragmentDepth = (vProjectedPos.z / vProjectedPos.w + 1.0) * 0.5;
                    
                    // Calculate intersection gradient
                    float intersection = 1.0 - smoothstep(
                        fragmentDepth - intersectionWidth, 
                        fragmentDepth + intersectionWidth, 
                        linearSceneDepth
                    );

                    // Gradient color
                    vec3 finalColor = intersectionColor * intersection;
                    
                    gl_FragColor = vec4(finalColor, intersection);
                }
            `,
            transparent: true
        });
    }

    render() {
        // Animate meshes
        this.mesh1.rotation.x += 0.01;
        this.mesh1.rotation.y += 0.02;
        this.mesh2.rotation.x -= 0.02;
        this.mesh2.rotation.z += 0.01;

        // Render to depth texture
        this.renderer.setRenderTarget(this.renderTarget);
        this.renderer.render(this.scene, this.camera);

        // Reset render target and render scene
        this.renderer.setRenderTarget(null);
        this.renderer.render(this.scene, this.camera);
    }

    animate() {
        requestAnimationFrame(() => this.animate());
        this.render();
        this.controls.update();
    }

    start() {
        this.animate();
    }
}

// Initialize and start the demo
const demo = new IntersectionGradientDemo();
demo.start();