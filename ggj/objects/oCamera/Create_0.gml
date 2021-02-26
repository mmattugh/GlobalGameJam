/// @description 

enum cStates {
	follow,
	follow_x,
	follow_y,
	centered,
	cutscene,
}


// parameters
zoom = 0.9;
zoom_lerp = 0.1;

follow_lerp_init = 0.15;
follow_lerp = follow_lerp_init;

follow_object = oCharacter;
screenshake_decrease = 1.5;
screenshake_curve_threshold = 10;
screenshake_curve = 0.9;

// 
screenshake = 0;
state = cStates.follow;

target_zoom = zoom;
station_object = noone;

instance_create_depth(0,0,0, oCharacterGhostAverage);

// set up views 
x = room_width/2;
y = room_height/2;
camera = camera_create_view(x, y, global.camera_width, global.camera_height);

view_enabled	= true;
view_visible[0] = true;
view_camera[0]	= camera;

display_set_gui_size(global.camera_width, global.camera_height);

bg_color = make_color_rgb(36, 34, 35);

//surface_resize(application_surface, global.camera_width*2, global.camera_height*2);
//if !(global.camera_set_window_size) {
//	window_set_size(global.camera_width*3, global.camera_width*3);
//	global.camera_set_window_size = true;
//}

if (room == level_1) {
	x = 3*room_width/2 - 32;
	y = room_height/2;
}

target_x = x;
target_y = y;

