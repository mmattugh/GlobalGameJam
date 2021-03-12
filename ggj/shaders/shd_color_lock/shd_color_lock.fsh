//
// Simplified LUT shader
// takes 2d LUT image, that is index on red channel and average of green and blue channels
// this works well for SELF because we really only care if things are red or not red.
//
varying vec2 v_vTexcoord;

// pass in palette and number of colors
uniform sampler2D palette;

// pass in mix percent, this is the amount of the default color remaining
uniform float mix_percent;

void main()
{
	// sample base texture from 
    vec4 base_color = texture2D( gm_BaseTexture, v_vTexcoord );
	
	// get palette coord for look up table texture
	vec2 palette_coord = vec2(base_color.r, 0.5*(base_color.g+base_color.b));
	
	// uncomment to require more intense red values to use red palette
	//vec2 palette_coord = vec2(base_color.r*base_color.r, 0.5*(base_color.g+base_color.b));

	// makes everything darker
	//palette_coord *= palette_coord;

	// mix palette color with base color
	gl_FragColor = mix(texture2D( palette, palette_coord), base_color, mix_percent);
}
