/// @description 

enum pStates {
	move,
	ghost,
	follow_trail,
	launch_from_trail,
	death,
	freeze,
	bench,
	cutscene_float,
	cutscene_grabbed,
	cutscene_flicked,
}

// movement parameters -- tweak these
move_speed	= 2;
move_accel_default = 0.5;
move_accel_launch = 0.05;
move_accel = move_accel_default;
move_decel = 0.505;
air_decel = 0.075;
grav_accel	= 0.20;
grav_max_speed = 8.505;
jump_accel	= 4;
launch_hsp  = 5;
launch_vsp  = 5;
smoke_FX = 0;

sprung_this_frame = false;

combo = 0;
combo_sin = 0;
combo_exclamations = "";
combo_just_now = 0;

coyote_time = 7;
coyote_timer = 0;

jump_buffer_time = 6;
jump_buffer_timer = 0;

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

played_footstep_sound = false;

trail_sound_id = noone;
trail_sound_pitch = 0;

draw_x = 0;
draw_y = 0;

reset_move_accel_timer = 0;

if !(instance_exists(oCamera)) {
	instance_create_depth(x,y,depth,oCamera);
	
	oCamera.follow_lerp = 1;
	with oCamera {
		event_perform(ev_step, 0);	
	}
	oCamera.follow_lerp = oCamera.follow_lerp_init;
}



function set_has_ghost() {
	
	has_ghost = true;
	combo = 0;
	combo_exclamations = "";	

	instance_create_depth(x,y,depth-2,fxRecharged);
	play_sound(Ghost_Recharge, 40, false, 1.0, 0.05, global.sound_volume*0.5);

	
	oCamera.screenshake += 2;
		repeat (5)
	{
		with instance_create_depth(x,y-16,depth+1,fxSmoke)
		{
			direction = random_range(0,360)
			speed = random_range(1,2)
		}
	}
	
}