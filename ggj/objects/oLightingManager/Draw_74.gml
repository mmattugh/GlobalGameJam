/// @description draw lighting

if !(lighting_enabled) {
	var window_w = window_get_width();
	var window_h = window_get_height();

	var ratio_w = window_w/global.camera_width ;
	var ratio_h = window_h/global.camera_height;

	var surface_w = 320;
	var surface_h = 320;

	var surface_x = (window_w - global.camera_width *ratio_w)/2;
	var surface_y = (window_h - global.camera_height*ratio_h)/2;

	if (window_w != window_h)
	{
		var w = 2;//+ sin(current_time*0.001);
		// draw border
		draw_rectangle_color(
			surface_x-w, surface_y-w, surface_x+surface_w+w, surface_y+surface_h+w, 
			global.colors.blue,global.colors.blue,global.colors.blue,global.colors.blue, false
		);
	}

	draw_surface_ext(application_surface, surface_x, surface_y, 1.0, 1.0, 0, c_white, 1.0);
	exit;
}

#region create surfaces as needed
if !(surface_exists(lighting_surface)) {
	exit;	
}

if !(surface_exists(quantization_surface)) {
	quantization_surface = surface_create(320, 320);
}	
#endregion

#region Apply quantization to the downscaled surface
	
	//set color lock parameters
shader_set(shd_color_lock);
	texture_set_stage(color_lock_uniform_palette, color_lock_palette_tex);
	shader_set_uniform_f(color_lock_uniform_mix_percent, color_lock_mix_percent)
	shader_set_uniform_f(color_lock_uniform_low_contrast, color_lock_low_contrast);

var window_w = window_get_width();
var window_h = window_get_height();

var ratio_w = window_w/global.camera_width ;
var ratio_h = window_h/global.camera_height;

var surface_w = 320;
var surface_h = 320;

var surface_x = (window_w - global.camera_width *ratio_w)/2;
var surface_y = (window_h - global.camera_height*ratio_h)/2;

if (window_w != window_h)
{
	var w = 2;//+ sin(current_time*0.001);
	var c = make_color_rgb(0, 70, 70);
	
	// draw border
	draw_rectangle_color(
		surface_x-w, surface_y-w, surface_x+surface_w+w, surface_y+surface_h+w, 
		c,c,c,c, false
	);
}

draw_surface_ext(quantization_surface, surface_x, surface_y, 1.0, 1.0, 0, c_white, 1.0);

shader_reset();
#endregion