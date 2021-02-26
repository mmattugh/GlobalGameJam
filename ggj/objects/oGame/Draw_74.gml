/// @description draw surface + border

var window_w = window_get_width();
var window_h = window_get_height();

var ratio_w = window_w/global.camera_width ;
var ratio_h = window_h/global.camera_height;

var surface_w = surface_get_width(application_surface);
var surface_h = surface_get_height(application_surface);

var surface_x = (window_w - global.camera_width *ratio_w)/2;
var surface_y = (window_h - global.camera_height*ratio_h)/2;

if (window_w != window_h)
{
	var w = 2;//+ sin(current_time*0.001);
	// draw border
	draw_rectangle_color(
		surface_x-w, surface_y-w, surface_x+surface_w/2+w, surface_y+surface_h/2+w, 
		global.colors.blue,global.colors.blue,global.colors.blue,global.colors.blue, false
	);
}

draw_surface_ext(application_surface, surface_x, surface_y, 1/2, 1/2, 0, c_white, 1.0);