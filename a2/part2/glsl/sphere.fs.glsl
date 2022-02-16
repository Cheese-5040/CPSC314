in vec3 interpolatedNormal;
in vec3 spherePos;
in float armDistance;
void main() {
	vec4 firstColor = vec4(0.92,0.0,1.0, 1.0); //purple
	vec4 secondColor = vec4(1.0,0.0,0.0,1.0); //red
	vec4 endColor = vec4(1.0, 0.75, 0.9,1.0);//pink

	float h = 0.5;
	//having the colour gradient 
	vec4 col = vec4(mix(mix(firstColor, secondColor, spherePos.y/h),mix(secondColor, endColor, (spherePos.y - h)/(1.0 - h)), step(h, spherePos.y)));
  	if (armDistance > 15.5){
		gl_FragColor = vec4(interpolatedNormal, 1.0);
	}
	else{
		gl_FragColor = col;

	}
}
