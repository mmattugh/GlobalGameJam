//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;

uniform vec3 color;

void main()
{
	gl_FragColor = vec4(color, texture2D( gm_BaseTexture, v_vTexcoord ).a);
}
