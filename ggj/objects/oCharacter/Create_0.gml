/// @description 

enum pStates {
	move,
	ghost,
	follow_trail,
	launch_from_trail,
}

// movement parameters -- tweak these
move_speed	= 2;
move_accel = 0.5;
move_decel = 0.505;
air_decel = 0.075;
grav_accel	= 0.20;
jump_accel	= 4;
launch_hsp  = 4.5;
launch_vsp  = 6;

on_ground = true;

state = pStates.move;

has_ghost = true;
ghost_regen_timer = 0;
ghost_regen_time = 60;

trail_target = noone;
trail_target_next = noone;

hsp = 0;
vsp = 0;
draw_xscale = 1.0;
draw_yscale = 1.0;
draw_angle = 0;
flipped = 1.0;

