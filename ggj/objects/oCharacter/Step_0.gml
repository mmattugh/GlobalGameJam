/// @description Insert description here
#region hazard collisions
mask_index = sPlayerHitbox;
// get hit by laser
var inst = instance_place(x,y,oLaser);
if (inst and inst.active and state != pStates.death) {
	if (audio_is_playing(trail_sound_id)) {
		audio_stop_sound(trail_sound_id);	
	}
	
	//      Camera      //
	scr_freeze(8);
	image_index = 0;
	state = pStates.death;
	play_sound(Self_Zapped_by_Laser, 50, false, 1.0, 0.02, global.sound_volume);
	
	exit;
}

if (place_meeting(x,y,pHazard)) {
	if (state != pStates.death) {
		image_index = 0;
		play_sound(Self_Death, 50, false, 1.0, 0.02, global.sound_volume);
		state = pStates.death;
		
		set_has_ghost();
		instance_destroy(fxRecharged);
	}
}

#endregion

// set on ground
on_ground = rotated_place_meeting(x, y, 0, 1, Solid) 

// coyote time
if (on_ground) {
	coyote_timer = coyote_time;	
} else {
	if (vsp < 0) { // if going up (jumping)
		coyote_timer = 0;
	} else {
		on_ground = (coyote_timer-- > 0);
	}
}


#region gameplay state machine
switch state {
	case pStates.move			  : #region
	
	#region husk specific code
	if (global.oldest_player_object != id) {
		if ((husk_lifetime+6) mod 60 == 0) {
			var timer = (husk_lifetime+6)/60;
			// create timer effect	
			with rotated_instance_create(x,y,5*flipped,4,depth-1,fxTimer) 
			{
				str = string(timer);
				target_offset += min(other.vsp, 0);
				
				if (timer <= 3) {
					target_target_image_xscale *= 1.25;
					target_target_image_yscale *= 1.25;
					target_image_xscale *= 1.25;
					target_image_yscale *= 1.25;
				}
				
				creator = other.id;
			}
		}
		husk_lifetime--;
		
		if (husk_lifetime <= 0 and !go_to_husk_used) {
			deactivate_this_husk();	
		}
	}
	#endregion
	
	// goto husk state
	if (go_to_husk_used && on_ground) {
		state = pStates.husk_used;	
	} else if (go_to_husk && on_ground) {
		state = pStates.husk;
	}
	
	// goto ghost state
	if (global.key_interact) && (has_ghost) {	
		state = pStates.ghost;
		
		//fx
		//instance_create_depth(x,y-8,0,fxStart);
		rotated_instance_create(x,y,0,-8,0,fxStart);
		has_ghost = false;
		ghost_regen_timer = ghost_regen_time;
		trail_target = noone;
		trail_target_next = noone;
		
		// set camera values
		oCamera.zoom = 0.9*oCamera.target_zoom;
		oCamera.screenshake += 7;
		
		var ghost_direction = 90;
		//with instance_create_depth(x,y-8,depth,oGhost) 
		with rotated_instance_create(x,y,0,-8,depth,oGhost) 
		{
			move_direction = ghost_direction;
			creator_player_object = other.id;
		}
		
		global.key_interact = false;
	}

	
	// horizontal speed	
	var h_dir = sign(global.key_right - global.key_left);
	
	if (sign(h_dir) != 0 or abs(hsp) > move_speed) {
		hsp = approach(hsp, move_speed * h_dir, move_accel);
	}
	
	if (sign(hsp) != h_dir) {
		if (on_ground) {
			hsp = approach(hsp, 0, move_decel);
		} else {
			hsp = approach(hsp, 0, air_decel);			
		}
	}
	
	// vertical speed
	if (on_ground) {
		if !(sprung_this_frame) {
			vsp = 0;
		}
	} else {
		vsp = approach(vsp, grav_max_speed, grav_accel);
		
	}
	
	// jump buffer 
	if (global.key_jump) {
		jump_buffer_timer = jump_buffer_time;	
	} else {
		if (jump_buffer_timer > 0) {
			jump_buffer_timer--;	
		}
	}
	
	
	// jump
	if (jump_buffer_timer > 0) && (on_ground) && (!sprung_this_frame) {
		//Jump FX
		//instance_create_depth(x,y,depth+1,fxJump);
		rotated_instance_create(x,y,0,0,depth+1,fxJump);
		//
		vsp = -jump_accel;
		draw_xscale = 0.5;
		draw_yscale = 1.5;
	}
	
	
	break;							#endregion
	case pStates.ghost			  : #region
	// goto prelaunch state
	
	if (global.key_interact && (!instance_exists(oGhost) or oGhost.go_back == false)) {
		scr_freeze(15)
		state = pStates.follow_trail;
		//fx
		//instance_create_depth(x,y-16,0,fxStart);
		rotated_instance_create(x,y,0,-16,0,fxStart);
		play_sound(choose(Shoot_01, Shoot_02, Shoot_03), 0, false, 0.8, 0.02, global.sound_volume);
		audio_stop_sound(oGhost.trail_sound_id);
	}
		
	// rapid decel
	hsp = lerp(hsp, 0, 0.8);
	vsp = lerp(vsp, 0, 0.8);
	
	
	break;							#endregion
	case pStates.follow_trail	  : #region

	if (trail_sound_id == noone) {
		trail_sound_id = audio_play_sound(Stretch_Loop_Reversed, 0, true);
		trail_sound_pitch = oGhost.trail_sound_pitch;
		audio_sound_gain(trail_sound_id, global.sound_volume, 0);
	}
	
	trail_sound_pitch = oGhost.trail_sound_pitch_min + oGhost.trail_sound_pitch_multiply * power((oGhost.trail_length/(oGhost.trail_length_max)), 2);
	audio_sound_pitch(trail_sound_id, trail_sound_pitch);
	
	if (instance_exists(oGhost)) {
		oGhost.spd = 0;
	}
	
	// goto launch state
	if (place_meeting(x,y,oGhost)) {
		hsp = 0;
		vsp = 0;
		scr_freeze(35)
		state = pStates.launch_from_trail;
		audio_stop_sound(trail_sound_id);
		trail_sound_id = noone;
		
		// combo stuff
		combo++;
		combo_just_now = 5;
		
		if (combo >= 3) {
			play_sound(Combo_Charge, 10, false, 0.5 + combo*0.05, 0., global.sound_volume);
		}
		
		if (combo >= 7) {
			combo_exclamations += "!";	
		}
		
		// unlock medals
		if (NG_ENABLED) {
			if (combo >= 25) {
				newgrounds_unlockmedal("62018")
				
			}
		
			if (combo >= 50) {
				newgrounds_unlockmedal("62019")			
			}
		
			if (combo >= 100) {
				newgrounds_unlockmedal("62020")			
			}
		}
	}
	
	if (instance_exists(oGhostTrail)) {
		if trail_target == noone or !instance_exists(trail_target) {
			trail_target = instance_nearest(x,y,oGhostTrail);
		}
		
		if trail_target_next == noone {
			trail_target_next = trail_target.next;	
		}
		
		// set angle
		draw_angle = point_direction(x,y,trail_target.x,trail_target.y) - 90;
		
		x = trail_target.x;
		y = trail_target.y;
		instance_destroy(trail_target, false);
		
		oGhost.trail_length--;
		
		
		if (trail_target_next != noone) {
			trail_target = trail_target_next;
			trail_target_next = trail_target.next;
		}
	}
	
	break;							#endregion
	case pStates.launch_from_trail: #region
	hsp = lengthdir_x(launch_hsp, oGhost.move_direction);
	vsp = lengthdir_y(launch_vsp, oGhost.move_direction);
	
	if (place_meeting(x,y,oGhost))
	{
		//fx
		//instance_create_depth(x,y-16,0,fxEnd);
		rotated_instance_create(x,y,0,-16,0,fxEnd);
		
		//Disable controls for a moment
		reset_move_accel_timer = 20;
		move_accel = move_accel_launch;
		
		instance_destroy(oGhost);
		instance_destroy(oGhostTrail, false);
		
		state = pStates.move;
		global.key_interact = false;
	}	
	
	break;							#endregion
	case pStates.husk: #region
	
	if (go_to_husk) {
		go_to_husk = false;
		vsp = 0;
		hsp = 0;
	}
	
	break; #endregion
	case pStates.husk_used: #region
	
	if (go_to_husk_used) {
		depth += 1;
		go_to_husk_used = false;
		vsp = 0;
		hsp = 0;
	}
	
	break; #endregion
	case pStates.death: #region
	hsp = 0;
	vsp = 0;
	
	if (global.oldest_player_object == id) {
		if instance_exists(pCameraStationZone) {
			instance_destroy(pCameraStationZone);
		}
	
		if audio_is_playing(Stretch_Loop) {
			audio_stop_sound(Stretch_Loop);	
		}
	
		if audio_is_playing(Stretch_Loop_Reversed) {
			audio_stop_sound(Stretch_Loop_Reversed);	
		}

		if (death_delay <= 0) {
			death_zoom = lerp(death_zoom, 0.9, 0.2);
	
		} else {
			death_delay--;	
		}
		oCamera.zoom = death_zoom;
		oCamera.zoom_lerp = 0.2;
		oCamera.target_x = x;
		oCamera.target_y = y;
	
	
		if (death_zoom < 0.81) {
			if (death_restart_delay <= 0) {
			
			} else {
				death_restart_delay--;
			}
		}
		
	} else if (global.active_player_object == id) {
		// return to oldest
		// turn current player to husk
		deactivate_this_husk();
		husk_lifetime = 0;

	} else {
		// TODO: dead husk gibs/ husk corpse
		instance_destroy();	
	}
	
	break; #endregion
	
	#region cutscene specific states
	case pStates.bench:
	hsp = 0;
	vsp = 0;
	
	var targ_x = oBench.x;
	var targ_y = oBench.y - 8;
	x = lerp(x, targ_x, 0.4);
	
	if abs(x-targ_x) < 5 {
		x = targ_x;	
	}
	
	y = approach(y, targ_y, 12);
		
	if (x == targ_x and y == targ_y and !instance_exists(oBenchGhost)) {
		oCamera.zoom = 0.9*oCamera.target_zoom;
		oCamera.screenshake += 7;
		
		var ghost_direction = 45;
		with instance_create_depth(x,y-8,depth,oBenchGhost) 
		{
			move_direction = ghost_direction;
			global.key_interact = false;
		}
	}
		
	break;
	
	case pStates.cutscene_float:
	hsp = 0;
	vsp = 0;
	var float_speed = 1;
	y = approach(y, oCutsceneFloat.y - 40, float_speed);
	x = lerp(x, oCutsceneFloat.x, 0.1);
	
	break;		
	case pStates.cutscene_grabbed:
	
	break;
	case pStates.cutscene_flicked:
	hsp = 12;
	oCamera.x = x;
	oCamera.y = y;
	break;
	#endregion
}
#endregion

#region graphics state machine
draw_xscale = lerp(draw_xscale, 1.0, 0.2);
draw_yscale = lerp(draw_yscale, 1.0, 0.2);

if (!on_ground and vsp > 0) {
	fall_time++;
} else {
	// just hit ground after falling
	if (fall_time != 0 && on_ground) {
		oCamera.screenshake += 0.05*fall_time;	
	}
	
	fall_time = 0;	
}


switch state {
	// same graphics state for both
	case pStates.move: #region
	{
	//fx
	smoke_FX++;
	if (smoke_FX > 2) && (has_ghost) {
		//with (instance_create_depth(random_range(x-2,x+2),y-16,oCharacter.depth+1,fxSmoke))
		rotated_instance_create(x,y,random_range(-2,2),-16,depth+1,fxSmoke);
		smoke_FX = 0;
	}
		
	draw_angle = angle_lerp(draw_angle, 270-global.down_direction, 0.5);
	if (sign(hsp) != 0) flipped = sign(hsp);
	
	if !on_ground {
		image_speed = 0;
		
		if (sprite_index != sCharacter_Air) {
			play_sound(Self_Jump, 50, false, 1.0, 0.05, global.sound_volume);	
		}
		
		sprite_index = sCharacter_Air;
		
		if (vsp > 0.2) image_index = 2;
		else if (vsp < -0.2) image_index = 0;
		else image_index = 1;
	} else {
		if (sprite_index == sCharacter_Air) {
			//instance_create_depth(x,y,depth+1,fxLand);	
			rotated_instance_create(x,y,0,0,depth+1,fxLand);
			draw_xscale = 1.5;
			draw_yscale = 0.5;
			
			play_sound(Land, 50, false, 1.0, 0.05, global.sound_volume);
		}
		
		image_speed = 1;
		if (hsp != 0) {
			sprite_index = sCharacter_Walk;
			
			// do footstep sound
			var pitch = 1.0;
			
			if (rotated_place_meeting(x,y, 0, 1, oWallPlatform)) {
				pitch = 1.2;	
			}
			
		
			
			if (image_index >= 2 and image_index < 3) 
			or (image_index >= 5) {
				if (!played_footstep_sound) {
					play_sound(choose(Footsteps_01, Footsteps_02), 50, false, pitch, 0.05, global.sound_volume);	
					played_footstep_sound = true;	
				}
				
				if (!fx_made_dust) {
					if (image_index >= 5) {
						rotated_instance_create(x,y,random_range(-2,2)+3,-2,depth,fxDust)	;
					} else {
						rotated_instance_create(x,y,random_range(-2,2)-3,-2,depth,fxDust);	
					}
					
					fx_made_dust = true;
					if (chance(2)) {
						fx_made_dust = false;	
					}
				}
			} else {
				played_footstep_sound = false;	
				fx_made_dust = false;
			}
		} else {
			sprite_index = sCharacter_Idle;
		}
	}
	
	}break;#endregion
	case pStates.ghost: #region
	sprite_index = sCharacter_Spirit;

	break; #endregion
	case pStates.follow_trail	  : #region
	//draw_angle += 60*dsin(oGhost.trail_length*6*360/oGhost.trail_length_max);
	
	
	if (trail_FX > 2)
	{
		//instance_create_depth(x,y,depth+1,fxCharacterTrail);
		rotated_instance_create(x,y,0,0,depth+1,fxCharacterTrail);
		trail_FX = 0;
	}
	else trail_FX ++;
	break; #endregion
	case pStates.launch_from_trail: #region
	
	break; #endregion
	case pStates.husk				: #region
	sprite_index = sCharacter_Sit;
	image_speed = 0.5;
	
	break; #endregion
	case pStates.husk_used: #region
	sprite_index = sCharacter_Sit_Used;
	image_speed = 0.5;

	
	break; #endregion
	case pStates.death: #region
	sprite_index = sCharacter_Death;
	image_speed = 1;
	break; #endregion
	
	case pStates.bench: #region
	sprite_index = sCharacter_Sleep;
	image_speed = 0.5;
	break; #endregion
	
	case pStates.cutscene_float:
	draw_x = 2 * dcos(current_time * 0.2);
	draw_y = 2 * dsin(current_time * 0.3);
	sprite_index = sCharacter_Spirit;
	break;
	case pStates.cutscene_flicked:
	draw_angle = angle_lerp(draw_angle, 270, 0.4);
	break
}

#endregion

// move 
var prev = image_angle;
image_angle = 270-global.down_direction;
xprevious = x;
yprevious = y;
move_with_physics();
image_angle = prev;

#region reset timers
// prevent timer regen til ghost state is finished
if (on_ground and has_ghost = false and state == pStates.move) {
	set_has_ghost();
}

if (reset_move_accel_timer > 0) {
	reset_move_accel_timer -= 1;
	
	if (reset_move_accel_timer == 0) {
		move_accel = move_accel_default;	
	}
}

combo_sin = dsin(current_time*0.4);
sprung_this_frame = false;

#endregion

// reset hitbox
//mask_index = sPlayerHitbox;
