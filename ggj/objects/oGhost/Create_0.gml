/// @description 

// tweakable
max_spd = 2.5;
turning_max_spd = 1.75;
acceleration = 0.5;

turn_speed = 5;
turn_lerp = 0.7;
immune_time = 30;

trail_length_max = 60;
trail_length = 0;

destroy_self = function() {
	oCharacter.state = pStates.move;
	instance_destroy(oGhostTrail);
	instance_destroy();
	
	// set camera values
	//oCamera.zoom = 1.1*oCamera.target_zoom;
	oCamera.screenshake = 15;
	
	exit;
}


// not tweakable
spd = 0;
trail_previous = noone;
move_direction = 0;
immune_timer = immune_time;

draw_xscale = 1.0;
draw_yscale = 1.0;
this_frame = false;