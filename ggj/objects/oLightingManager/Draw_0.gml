/// @description build lighting surface
if !(lighting_enabled) {
	exit;
}

// create surface if needed
if !(surface_exists(lighting_surface)) {
	lighting_surface = surface_create(320+camera_border, 320+camera_border);
}	

surface_set_target(lighting_surface);

// clear surface to base lighting color
var val = 255*base_light;
var base_color = make_color_rgb(val, val, val)
draw_clear_alpha(base_color, 1.0);


#region // draw entities
// get camera coords
var camera_x = camera_get_view_x(view_camera[0])+160*(oCamera.zoom-1.0);
var camera_y = camera_get_view_y(view_camera[0])+160*(oCamera.zoom-1.0);

shader_set(shd_one_color);
	shader_set_uniform_f(one_color_uniform_color, 0.5, 0.5, 0.5);
	
with oGetsPaused {
	//if !(object_is_ancestor(object_index, fxParent)) {
	//	draw_circle_color(x-camera_x,y-camera_y,sprite_width,entity_light_color,c_black,false);
	//}
	if (visible) {
		x -= camera_x;
		y -= camera_y;
		event_perform(ev_draw, 0);
		x += camera_x;
		y += camera_y;
	}
}	

shader_reset();
#endregion

gpu_set_blendmode(bm_add);
// draw lights
with oLight {
	draw_circle_color(x-camera_x,y-camera_y,radius,color,c_black,false);
}

// reset
gpu_set_blendmode(bm_normal);
surface_reset_target();