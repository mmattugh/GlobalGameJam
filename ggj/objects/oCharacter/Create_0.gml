/// @description 

enum pStates {
	move,
	ghost,
	follow_trail,
	launch_from_trail,
	wall_slide,
	husk,
	husk_used,
	death,
	freeze,
	bench,
	cutscene_float,
	cutscene_grabbed,
	cutscene_flicked,
}

if (object_index == oCharacter) {
	global.active_player_object = id;
	global.oldest_player_object = id;

}
go_to_husk = false;
go_to_husk_used = false;

husk_lifetime = (10 + .5) * 60; // 10 seconds


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

physics_xprevious = x;
physics_yprevious = y;
physics_mass = 3;// 

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
fx_made_dust = false;

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
	#region // save combo
	if (combo > global.best_combo) {
		ini_open(SAVE_FILE);
		ini_write_real("save", "best_combo", combo);
		ini_close();
		global.best_combo = combo;
	}
	#endregion
	
	has_ghost = true;
	combo = 0;
	combo_exclamations = "";	

	//instance_create_depth(x,y,depth-2,fxRecharged);
	rotated_instance_create(x,y,0,0,depth-2,fxRecharged);
	play_sound(Ghost_Recharge, 40, false, 1.0, 0.05, global.sound_volume*0.5);
	
	oCamera.screenshake += 2;
		repeat (5)
	{
		//with instance_create_depth(x,y-16,depth+1,fxSmoke)
		with rotated_instance_create(x,y,0,-16,depth+1,fxSmoke)
		{
			direction = random_range(0,360)
			speed = random_range(1,2)
		}
	}
	
}

function activate_husk(husk_id) {
	scr_freeze(60);
	oCamera.screenshake += 8;
	oCamera.zoom = 1.1;
	
	// activate husk
	husk_id.state = pStates.move;
	husk_id.go_to_husk = false;
	husk_id.go_to_husk_used = false;
	husk_id.husk_lifetime = max(husk_id.husk_lifetime, 10);
	global.active_player_object = husk_id;
			
	#region unfuckn
	var angle_change_since_init = round(-((global.down_direction-husk_id.draw_angle+720-270) mod 360) + 180);
	if (abs(angle_change_since_init) == 90) { 
		with husk_id {
			var prev = image_angle;
			image_angle = 270-global.down_direction
			obj_unfuck(angle_change_since_init);	
			image_angle = prev;
		}
	} else if (abs(angle_change_since_init) == 180 or abs(angle_change_since_init) == 0) {
		with (husk_id) {
			var prev = image_angle;
			image_angle = 270-global.down_direction
			obj_unfuck(180);	
			image_angle = prev;
		}
	}
	#endregion
			
	// make sure jump doesnt get cancelled
	rotated_instance_create(x,y,0,0,depth+1,fxJump);
	repeat(8) {
		with (rotated_instance_create(x,y,random_range(-2,2),-8,depth+1,choose(fxSmoke,fxSmoke,fxSmokeLarge)))
		{
		other.smoke_FX = 0;
		}
	}
	
	husk_id.draw_xscale = 1.5;
	husk_id.draw_yscale = 0.5;
	with husk_id {
		vsp = -1;
		move_with_physics();
	}
	husk_id.vsp -= husk_id.jump_accel/2;
}

function deactivate_this_husk() {
	id.state = pStates.move;
	id.go_to_husk_used = true;
	//id.hsp = 0;
	//id.vsp = 0;
	
	if (instance_exists(oGhost)) {
		with oGhost {
			// destroy self
			instance_destroy();
	
			rotated_instance_create(x,y,0,0,depth-1,fxEnd);	
		}
	}
	
	activate_husk(global.oldest_player_object);
}