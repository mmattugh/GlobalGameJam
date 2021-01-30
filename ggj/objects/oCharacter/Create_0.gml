/// @description 

enum pStates {
	move,
	ghost,
	follow_trail,
	launch_from_trail,
	death,
}

// movement parameters -- tweak these
move_speed	= 2;
move_accel = 0.5;
move_decel = 0.505;
air_decel = 0.075;
grav_accel	= 0.20;
jump_accel	= 4;
launch_hsp  = 5;
launch_vsp  = 5;
smoke_FX = 0;

on_ground = true;
fall_time = 0;

state = pStates.move;

has_ghost = true;
ghost_regen_timer = 0;
ghost_regen_time = 60;

trail_target = noone;
trail_target_next = noone;
trail_FX = 0;

hsp = 0;
vsp = 0;
draw_xscale = 1.0;
draw_yscale = 1.0;
draw_angle = 0;
flipped = 1.0;

death_zoom = 1.0;
death_delay = 5;
death_restart_delay_max = 15;
death_restart_delay = death_restart_delay_max;

trail_sound_id = noone;
trail_sound_pitch = 0;

if !(instance_exists(oCamera)) {
	instance_create_depth(x,y,depth,oCamera);
	
	oCamera.follow_lerp = 1;
	with oCamera {
		event_perform(ev_step, 0);	
	}
	oCamera.follow_lerp = oCamera.follow_lerp_init;
}



