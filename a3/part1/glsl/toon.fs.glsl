// HINT: Don't forget to define the uniforms here after you pass them in in A3.js
uniform vec3 toonColor;
uniform vec3 toonColor2;
uniform vec3 outlineColor;

// The value of our shared variable is given as the interpolation between normals computed in the vertex shader
// below we can see the shared variable we passed from the vertex shader using the 'in' classifier
in vec3 interpolatedNormal;
in vec3 lightDirection;
in vec3 viewPosition;
in float fresnel;

void main() {
    // HINT: Compute the light intensity the current fragment by determining
    // the cosine angle between the surface normal and the light vector
    // float intensity = 1.0;

    // HINT: Define ranges of light intensity values to shade. GLSL has a
    // built-in `ceil` function that you could use to determine the nearest
    // light intensity range.
    
    // HINT: You should use two tones of colors here; `toonColor` is a cyan
    // color for brighter areas and `toonColor2` is a blue for darker areas.
    // Use the light intensity to blend the two colors, there should be 3 distinct
    // colour regions 
    float intensity = dot(normalize(lightDirection), normalize(interpolatedNormal)); //intensity is dependent on the light direction since it is
    intensity = ceil(intensity*2.0)/2.0; //set the intensity to a step function so that it can be classified into different colours
    vec3 out_Toon;
	if (intensity ==1.0){
		out_Toon = mix(toonColor, toonColor2, 1.0 - intensity);   
    }   
	else if (intensity == 0.5){
        out_Toon = toonColor2; //colour for shading
    }
	else if (intensity == 0.0){
		out_Toon =  toonColor; //colour for shading 
    }
	out_Toon = mix(toonColor, toonColor2, 1.0 - intensity);   //set the colour mixing so that there is a blend of two colours


    // HINT: To achieve the toon silhouette outline, set a dark fragment color
    // if the current fragment is located near the edge of the 3D model.
    // Use a reasonable value as the threshold for the silhouette thickness
    // (i.e. proximity to edge).
    float silhouette = fresnel; //the fresnel is dependent on the viewDirection so moving the orb does not affect it 
    if (silhouette < 0.35)
		out_Toon = outlineColor; //set the thickness of the outline

    gl_FragColor = vec4(out_Toon, 1.0);
}
