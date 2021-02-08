/// @description Insert description here
on_ground = place_meeting(x,y+1,Solid) 

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

mask_index = sPlayerHitbox;

// get hit by laser
var inst = instance_place(x,y,oLaser);
if (inst and inst.active and state != pStates.death) {
	//destroy_self();		
	
	if (audio_is_playing(trail_sound_id)) {
		audio_stop_sound(trail_sound_id);	
	}
	
	//  //  //  //  //  //
	//      Camera      //
	//  //  //  //  //  //
	scr_freeze(8);
		image_index = 0;
	state = pStates.death;
	play_sound(Self_Zapped_by_Laser, 50, false, 1.0, 0.02, global.sound_volume);
	
	exit;
}

#region gameplay state machine
switch state {
	case pStates.move			  : #region
	// goto ghost state
	if (global.key_interact) && (has_ghost) {
		
		state = pStates.ghost;
		//fx
		instance_create_depth(x,y-8,0,fxStart);
		has_ghost = false;
		ghost_regen_timer = ghost_regen_time;
		trail_target = noone;
		trail_target_next = noone;
		
		// set camera values
		oCamera.zoom = 0.9*oCamera.target_zoom;
		oCamera.screenshake += 7;
		
		var ghost_direction = 90;
		with instance_create_depth(x,y-8,depth,oGhost) 
		{
			move_direction = ghost_direction;
			global.key_interact = false;
		}
	}
	
	// horizontal speed	
	var h_dir = sign(global.key_right - global.key_left);
	
	if (sign(h_dir) != 0) {
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
		vsp = 0;
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
	if (jump_buffer_timer > 0) && (on_ground) {
		//Jump FX
		instance_create_depth(x,y,depth+1,fxJump);
		//
		vsp = vsp - jump_accel;
		draw_xscale = 0.7;
		draw_yscale = 1.3;
	}
	
	
	break;							#endregion
	case pStates.ghost			  : #region
	// goto prelaunch state
	sprite_index = sCharacter_Spirit;
	if (global.key_interact && oGhost.go_back == false) {
		scr_freeze(15)
		state = pStates.follow_trail;
		//fx
		instance_create_depth(x,y-16,0,fxStart);
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
	
	oGhost.spd = 0;
	
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
		instance_create_depth(x,y-16,0,fxEnd);
		
		//Disable controls for a moment
		alarm[0] = 20;
		move_accel = 0.05;
		
		instance_destroy(oGhost);
		instance_destroy(oGhostTrail, false);
		
		state = pStates.move;
		global.key_interact = false;
	}	
	
	break;							#endregion
	case pStates.death: #region
	
	if instance_exists(pCameraStationZone) {
		instance_destroy(pCameraStationZone);
	}
	
	if audio_is_playing(Stretch_Loop) {
		audio_stop_sound(Stretch_Loop);	
	}
	
	if audio_is_playing(Stretch_Loop_Reversed) {
		audio_stop_sound(Stretch_Loop_Reversed);	
	}
	
	hsp = 0;
	vsp = 0;
	
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
	
	break; #endregion
	
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
	case pStates.move:
	{
		//fx
		smoke_FX++;
		if (smoke_FX > 2) && (has_ghost) with (instance_create_depth(random_range(x-2,x+2),y-16,oCharacter.depth+1,fxSmoke))
		{
		other.smoke_FX = 0;
		}
		
		
			draw_angle = 0;
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
			instance_create_depth(x,y,depth+1,fxLand);			
			draw_xscale = 1.3;
			draw_yscale = 0.7;
			
			play_sound(Land, 50, false, 1.0, 0.05, global.sound_volume);
		}
		
		image_speed = 1;
		if (hsp != 0) {
			sprite_index = sCharacter_Walk;
			
			// do footstep sound
			var pitch = 1.0;
			
			if (place_meeting(x,y+1, oWallPlatform)) {
				pitch = 1.2;	
			}
			
			if (image_index >= 2 and image_index < 3) 
			or (image_index >= 5) {
				if (!played_footstep_sound) {
					play_sound(choose(Footsteps_01, Footsteps_02), 50, false, pitch, 0.05, global.sound_volume);	
					played_footstep_sound = true;	
				}
			} else {
				played_footstep_sound = false;	
			}
		} else {
			sprite_index = sCharacter_Idle;
		}
	}
	
	}break;#region
	case pStates.ghost:
	sprite_index = sCharacter_Spirit;

	break; #endregion
	case pStates.follow_trail	  : #region
	//draw_angle += 60*dsin(oGhost.trail_length*6*360/oGhost.trail_length_max);
	
	
	if (trail_FX > 2)
	{
		instance_create_depth(x,y,depth+1,fxCharacterTrail);
		trail_FX = 0;
	}
	else trail_FX ++;
	break; #endregion
	case pStates.launch_from_trail: #region
	
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


#region move object

if !place_meeting(x+hsp, y+vsp, Solid) {
	x += hsp;
	y += vsp;
} else {
	var temp_hsp = hsp;
	var temp_vsp = vsp;

	var sign_hsp = sign(hsp);
	var sign_vsp = sign(vsp);
	//var frac_hsp = frac(hsp);
	//var frac_vsp = frac(vsp);
	while (abs(temp_hsp) > 0 && abs(temp_vsp) > 0) {
		if !(place_meeting(x+sign_hsp, y+sign_vsp, Solid)) {
			x += sign_hsp;
			y += sign_vsp;				  
			temp_hsp = approach(temp_hsp, 0, 1);
			temp_vsp = approach(temp_vsp, 0, 1);
		} else {
			if place_meeting(x + sign_hsp, y, Solid) {
				temp_hsp = 0;	
				hsp = 0;
			}
			if place_meeting(x, y + sign_vsp, Solid) {
				temp_vsp = 0;
				vsp = 0;
			}
			break;
		}
	}
	
	for (var i = 0; i < abs(temp_hsp); i++) {
		if !place_meeting(x + sign_hsp, y, Solid) {
			x += sign_hsp;
		} else {
			temp_hsp = 0;
			hsp = 0;
			break;
		}
	}
	
	for (var i = 0; i < abs(temp_vsp); i++) {
		if !place_meeting(x, y + sign_vsp, Solid) {
			y += sign_vsp;
		} else {
			temp_vsp = 0;
			vsp = 0;
			break;
		}
	}
}

#endregion

#region reset timers
// prevent timer regen til ghost state is finished
if (on_ground and has_ghost = false and state == pStates.move) {
	
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

combo_sin = dsin(current_time*0.4);
#endregion