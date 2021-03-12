//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D lighting;
uniform vec2 noise_settings; //vignette inner circle size, vignette outter circle size, noise strength
uniform vec2 rotation; //vignette inner circle size, vignette outter circle size, noise strength

// 2D Random
float random(in float seed, in vec2 st) {
    return fract(sin(seed + dot(st.xy,
                         vec2(12.9898,78.233)))
                 * 43758.5453123);
}

// 2D Noise based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float noise(in vec2 st, in float seed) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    // Four corners in 2D of a tile
    float a = random(seed, i);
    float b = random(seed, i + vec2(1.0, 0.0));
    float c = random(seed, i + vec2(0.0, 1.0));
    float d = random(seed, i + vec2(1.0, 1.0));

    // Smooth Interpolation

    // Cubic Hermine Curve.  Same as SmoothStep()
    vec2 u = f*f*(3.0-2.0*f);
    // u = smoothstep(0.,1.,f);

    // Mix 4 coorners percentages
    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

vec2 rotateUV(vec2 uv, float rot)
{
    float mid = 0.5;
    return vec2(
        cos(rot) * (uv.x - mid) + sin(rot) * (uv.y - mid) + mid,
        cos(rot) * (uv.y - mid) - sin(rot) * (uv.x - mid) + mid
    );
}

vec2 normalizeUV(vec2 uv, float zoom) {
	
	return (uv*zoom) + vec2(0.5*(1.0-zoom));	
}

void main()
{
	vec4 light = texture2D(lighting, normalizeUV(rotateUV(v_vTexcoord, -rotation.x), rotation.y));
	vec4 color = texture2D(gm_BaseTexture, v_vTexcoord);
	vec4 final;
	
	final = color * light * 2.0;
	
	//final.rgb *= 0.9;
	
	// noise 
    float n = noise_settings.x*(noise(v_vTexcoord*500.0, noise_settings.y)-1.0);
	//final += n*(light*2.0-1.0); //uncomment to change noise based on light difference from mean
	final += n;
	
    gl_FragColor = final;
}