// HINT: Don't forget to define the uniforms here after you pass them in in A3.js
uniform vec3 spherepoistion ;
uniform float ticks; 
// The value of our shared variable is given as the interpolation between normals computed in the vertex shader
// below we can see the shared variable we passed from the vertex shader using the 'in' classifier
in vec3 interpolatedNormal;
in vec3 lightDirection;
in vec3 vertexPosition;

void main() {
    // HINT: Compute the light intensity the current fragment by determining
    // the cosine angle between the surface normal and the light vector.
    float intensity=dot(normalize(lightDirection), normalize(interpolatedNormal));

    // HINT: Pick any two colors and blend them based on light intensity
    // to give the 3D model some color and depth.
    vec3 red = vec3(1.000, 0.266, 0.20);    //red colour
    vec3 gold = vec3(1.000, 0.843, 0.00);   //gold colour
    vec3 out_Stripe = mix(gold, red, 1.0 - intensity);   //blend them 
    
    float squareLength = 0.1;
    float remainderX = mod(vertexPosition.x, squareLength);             // cut in the x direction every 0.1
    float remainderY = mod(vertexPosition.y+ticks*0.2, squareLength);   // cut in the y direction every 0.1, and also make it move down every 0.1 seconds
    float remainderZ = mod(vertexPosition.z, squareLength);             //cut in the z direction every 0.1
    if(remainderX < 0.02 || remainderY < 0.02 || remainderZ < 0.02) {   //removing the borders so it looks like boxes
    discard;
    }
    // HINT: Set final rendered colour
    gl_FragColor = vec4(out_Stripe, 1.0);
}
