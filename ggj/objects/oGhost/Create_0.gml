/// @description 

// tweakable
max_spd = 2.5;
turning_max_spd = 1.75;
acceleration = 0.25;

turn_speed = 5;
turn_lerp = 0.7;
immune_time = 30;

destroy_self = function() {
	oCharacter.state = pStates.move;
	instance_destroy(oGhostTrail);
	instance_destroy();
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