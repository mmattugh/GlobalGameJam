/// @description 

enum cStates {
	follow,
	follow_x,
	follow_y,
	centered,
}


// parameters
zoom = 1;
zoom_lerp = 0.1;

follow_lerp = 0.15;
y_offset = 32;
follow_object = oCharacter;
screenshake_decrease = 1.5;
screenshake_curve_threshold = 10;
screenshake_curve = 0.9;

// 
screenshake = 0;
state = cStates.follow;
target_x = 0;
target_y = 0;
target_zoom = zoom;
station_object = noone;

instance_create_layer(0,0,"Instances", oCharacterGhostAverage);

// set up views 
x = room_width/2;
y = room_height/2;
camera = camera_create_view(x, y, global.camera_width, global.camera_height);

view_enabled	= true;
view_visible[0] = true;
view_camera[0]	= camera;

surface_resize(application_surface, global.camera_width*2, global.camera_height*2);
//if !(global.camera_set_window_size) {
//	window_set_size(global.camera_width*3, global.camera_width*3);
//	global.camera_set_window_size = true;
//}