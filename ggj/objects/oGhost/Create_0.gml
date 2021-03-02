/// @description 
depth = 0;
// tweakable
default_max_spd = 2.5;
turning_max_spd = 1.75;
in_red_spd = 1.5;
max_spd = default_max_spd;

acceleration = 0.5;

played_end_sound = false;

turn_speed = 8;
turn_lerp = 0.5;

// values used when colliding with red;
in_red_turn_speed = 4;
in_red_turn_lerp = 0.4;

immune_time = 60;

wall_slow_threshold = 3;
wall_slow = false;
wall_slow_percent = 0.4;

trail_length_max = 23;
trail_length_max_init = trail_length_max;

trail_length = 0;
turn_direction = 0;

left_arrow_scale = 1.0;
right_arrow_scale = 1.0;

arrows_enabled = (global.rooms < 5);

trail_sound_id = audio_play_sound(Stretch_Loop, 0, true);
audio_sound_gain(trail_sound_id, global.sound_volume, 0);

trail_sound_pitch_min = 0.3;
trail_sound_pitch_multiply = 2.7;

creator_player_object = noone;

destroy_self = function() {
	//oCharacter.state = pStates.move;
	//instance_destroy(oGhostTrail);
	//instance_destroy();
	go_back = true;
	audio_stop_sound(trail_sound_id);
	trail_sound_id = noone;
	
	trail_target = trail_previous;
	// set camera values
	//oCamera.zoom = 1.1*oCamera.target_zoom;
	oCamera.screenshake = 15;
	
	with instance_create_depth(	x + lengthdir_x(9, move_direction+270-global.down_direction),
								y + lengthdir_y(9, move_direction+270-global.down_direction),
								depth-1, fxGhostBonk) {
		image_angle = other.move_direction+270-global.down_direction;							
	}
	
	exit;
}

go_back = false;
trail_target = noone;
trail_target_next = noone;


// not tweakable
spd = 0;
trail_previous = noone;
move_direction = 0;
immune_timer = immune_time;
trail_sound_pitch = 0;

draw_xscale = 1.0;
draw_yscale = 1.0;
this_frame = false;