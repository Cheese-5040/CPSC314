uniform float time ;
uniform vec3 armadilloPosition;
out vec3 interpolatedNormal;
out vec3 spherePos;
out float armDistance;
void main() {

    interpolatedNormal = normal;
    //x,y,z of the sphere coordinates
    float x = position.x; 
    float y = position.y;
    float z = position.z;
    float a = 0.0;
    spherePos = position;
    vec3 modifiedPos = vec3(0.0,0.0,0.0);
    vec3 newPosition = vec3(0.0,0.0,0.0);
    //obtain the distance between the sphere and the armadillo 
    vec4 realSpherePos =  modelMatrix* vec4(position,1.0);
    armDistance = distance(vec3(realSpherePos), armadilloPosition);

    //the condition to prevent the size of sphere to become too small (sine will reach 0)
    
    if (armDistance > 15.5){
        if (abs(sin(time))>0.5){
            a = 1.4*(abs(sin(time))) ;
        }
        else{
            a = 0.6; 
        }
        // equations for x,y,z of the deformation based on the unit time

        x = x*a*sqrt(pow(a,2.0) - pow(y,2.0)/2.0 - pow(z,2.0)/2.0 + pow(y,2.0)*pow(z,2.0)/(3.0*pow(a,2.0)));
        y = y*a*sqrt(pow(a,2.0)- pow(z,2.0)/2.0 - pow(x,2.0)/2.0 + pow(z,2.0)*pow(x,2.0)/(3.0*pow(a,2.0)));
        z = z*a*sqrt(pow(a,2.0) - pow(x,2.0)/2.0 - pow(y,2.0)/2.0 + pow(y,2.0)*pow(x,2.0)/(3.0*pow(a,2.0)));
    }
    else{
        if (abs(sin(time))>0.75){
            a = 1.0*(abs(sin(time))) ;
        }
        else{
            a = 0.75; 
        }
        //transforming the sphere / cube distortion to pulsating heart instead 
        // equations for x,y,z of the deformation based on the unit time
        z = z*a*sqrt(pow(a,2.0) - pow(y,2.0)/2.0 - pow(x,2.0)/2.0 + pow(x,2.0)*pow(y,2.0)/(3.0*pow(a,2.0)));
        y = 3.0+-(4. + 1.2 * y - abs(x) * 1.2*a*sqrt(max((20. - abs(x)) / 15., 0.)));
        x= x * (2. - y / 15.);
    }
    // TODO Q4 transform the vertexpos position to create deformations
    // Make sure to change the size of the orb sinusoidally with time.
    // The deformation must be a function on the vertice's position on the sphere.
    
    
    newPosition = vec3(x, y, z);
    modifiedPos = 1.5*newPosition;
    // Multiply each vertex by the model matrix to get the world position of each vertex, 
    // then the view matrix to get the position in the camera coordinate system, 
    // and finally the projection matrix to get final vertex position.
    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(modifiedPos, 1.0);
}
