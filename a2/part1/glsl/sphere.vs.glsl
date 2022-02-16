uniform float time ;

out vec3 interpolatedNormal;

void main() {

    interpolatedNormal = normal;
    //x,y,z of the sphere coordinates
    float x = position.x; 
    float y = position.y;
    float z = position.z;
    float a = 0.0;

    //the condition to prevent the size of sphere to become too small (sine will reach 0)
    if (abs(sin(time))>0.5){
        a = 1.5*(abs(sin(time))) ;
    }
    else{
        a = 0.75; 
    }
    // TODO Q4 transform the vertexpos position to create deformations
    // Make sure to change the size of the orb sinusoidally with time.
    // The deformation must be a function on the vertice's position on the sphere.
    
    // equations for x,y,z of the deformation based on the unit time
    float newX = x*a*sqrt(pow(a,2.0) - pow(y,2.0)/2.0 - pow(z,2.0)/2.0 + pow(y,2.0)*pow(z,2.0)/(3.0*pow(a,2.0)));
    float newY = y*a*sqrt(pow(a,2.0)- pow(z,2.0)/2.0 - pow(x,2.0)/2.0 + pow(z,2.0)*pow(x,2.0)/(3.0*pow(a,2.0)));
    float newZ = z*a*sqrt(pow(a,2.0) - pow(x,2.0)/2.0 - pow(y,2.0)/2.0 + pow(y,2.0)*pow(x,2.0)/(3.0*pow(a,2.0)));
    
    vec3 newPosition = vec3(newX, newY, newZ);
    vec3 modifiedPos = 1.5*newPosition;
    
    // Multiply each vertex by the model matrix to get the world position of each vertex, 
    // then the view matrix to get the position in the camera coordinate system, 
    // and finally the projection matrix to get final vertex position.
    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(modifiedPos, 1.0);
}
