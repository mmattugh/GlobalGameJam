

lighting_enabled = LIGHTING_ENABLED;

// parameters
base_light = 0.50;
lighting_noise_settings = 0.06
noise_fps = 12;

camera_border = 0;

color_lock_palette_tex = sprite_get_texture(sPal, 0);
color_lock_mix_percent = 0.00; // how much of the base color is preserved in to the output;\

// uniforms 
lighting_uniform_noise_settings = shader_get_uniform(shd_lighting, "noise_settings");
lighting_uniform_rotation_matrix= shader_get_uniform(shd_lighting, "rotation");
color_lock_uniform_palette		= shader_get_sampler_index(shd_color_lock, "palette");
color_lock_uniform_mix_percent  = shader_get_uniform(shd_color_lock, "mix_percent");
one_color_uniform_color			= shader_get_uniform(shd_one_color, "color");

lighting_surface = surface_create(320+camera_border, 320+camera_border);
quantization_surface = surface_create(320, 320);

surface_resize(application_surface, 320, 320);