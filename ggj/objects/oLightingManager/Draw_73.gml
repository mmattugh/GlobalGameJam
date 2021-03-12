/// @description Insert description here
// You can write your code in this editor
if !(surface_exists(lighting_surface)) {
	exit;	
}

if !(surface_exists(quantization_surface)) {
	quantization_surface = surface_create(320, 320);
}	

// set target to the quantization surface to guarantee pixel perfect
surface_set_target(quantization_surface);

// set lighitng shader and uniforms
shader_set(shd_lighting);
	var tex = surface_get_texture(lighting_surface);
	var handle = shader_get_sampler_index(shd_lighting,"lighting");
	texture_set_stage(handle,tex);
	shader_set_uniform_f(lighting_uniform_noise_settings, lighting_noise_settings, round(current_time*0.001*noise_fps) mod noise_fps); //vignette inner circle size, vignette outter circle size, noise strength, noise enable (1 or 0 only).
	shader_set_uniform_f(lighting_uniform_rotation_matrix, oCamera.angle*pi/180, 1.0); //vignette inner circle size, vignette outter circle size, noise strength, noise enable (1 or 0 only).
// draw game
draw_surface_ext(application_surface,0,0,1/oCamera.zoom,1/oCamera.zoom,0,c_white,1.0);

// reset everything
shader_reset();
surface_reset_target();