/// @description 
mask_index = sPlayerHitbox;

if oCharacter.state == pStates.death {
	instance_destroy(oGhostTrail);
	instance_destroy();
	
	instance_create_depth(x,y,depth-1,fxEnd);
	
	exit;	
}


if (go_back) {
	image_index = 1;
	
	if (trail_sound_id == noone) {
		trail_sound_id = audio_play_sound(Stretch_Loop_Reversed, 0, true);
	}
	
	trail_sound_pitch = trail_sound_pitch_min + trail_sound_pitch_multiply * power((trail_length/(trail_length_max)), 2);
	audio_sound_pitch(trail_sound_id, trail_sound_pitch);
	
	spd = 0;
	
	if (instance_exists(oGhostTrail)) {
		if trail_target == noone or !instance_exists(trail_target) {
			trail_target = instance_nearest(x,y,oGhostTrail);
		}
		
		if trail_target_next == noone {
			trail_target_next = trail_target.prev;	
		}
		
		// set angle
		draw_angle = point_direction(trail_target.x,trail_target.y,x,y) - 90;
		
		x = trail_target.x;
		y = trail_target.y;
		instance_destroy(trail_target, false);
		
		trail_length--;
		
		if (trail_target_next != noone) {
			trail_target = trail_target_next;
			trail_target_next = trail_target.prev;
		}
	} else {
		oCharacter.state = pStates.move;
		//oCamera.zoom = 0.9*oCamera.target_zoom;
		oCamera.screenshake = 4;
		scr_freeze(10);
		show_debug_message("destroyed");
		audio_stop_sound(trail_sound_id);
		instance_destroy();
	}
} else {
	switch oCharacter.state {
		case pStates.death: #region
	
		instance_destroy(oGhostTrail);
		instance_destroy();		
	
		break; #endregion
		case pStates.ghost			  : #region
	
		#region create new trail object
		this_frame = !this_frame;
	
		if (this_frame) {
			var trail_new = instance_create_depth(x,y,depth,oGhostTrail);
	
			var forgiveness_time = 40 * (max_spd+1-spd);
			with trail_new {
				image_xscale = 0;
				image_yscale = 0;
				forgiveness = forgiveness_time;
			}
	
			if trail_previous != noone {
				trail_previous.next = trail_new;
			}
		
			trail_new.prev = trail_previous;
			trail_previous = trail_new;
		
			trail_length++;
		}
	
		if (trail_length >= trail_length_max) {
			spd = 0;
			
			scr_freeze(40)
			oCharacter.state = pStates.follow_trail;
			oCamera.screenshake += 5;
			play_sound(choose(Shoot_01, Shoot_02, Shoot_03), 0, false, 1.0, 0.02, global.sound_volume);
			audio_stop_sound(trail_sound_id);
		}
	
		#endregion
	
		#region check for collision
		if	(place_meeting(x,y,oWall)) {
			destroy_self();
			
			// TODO: bump sfx
		}
		
		if (place_meeting(x,y,oLaser)) {
			//destroy_self();		
			
			if (audio_is_playing(trail_sound_id)) {
				audio_stop_sound(trail_sound_id);	
			}
			
			// TODO: zapped sfx			
			oCharacter.state = pStates.death;
			exit;
		}
	
		var inst = instance_place(x,y,oGhostTrail);
		if (inst != noone and inst.forgiveness <= 0) {
			if (immune_timer <= 0) {
				destroy_self();
			}
		}
	
		if (place_meeting(x,y,oCharacter)) {
			if (immune_timer <= 0) {
				destroy_self();
			}
		}
	
		if (immune_timer > 0) immune_timer--;
		#endregion
	
		#region move
		var turn_direction = global.key_left - global.key_right;
		var turn_direction_pressed = global.key_left_p - global.key_right_p;
		move_direction = angle_lerp(move_direction, move_direction + turn_direction * turn_speed, turn_lerp);
	
		if turn_direction_pressed == 0 {
			spd = approach(spd, max_spd, acceleration);
		} else {
			spd = min(spd, turning_max_spd);
		}
	
		// slow down slightly if heading towards wall {
		if (place_meeting(x+lengthdir_x(spd*wall_slow_threshold, move_direction), y+lengthdir_y(spd*wall_slow_threshold,move_direction), Solid)) {
			if (wall_slow == false) {
				spd *= wall_slow_percent;	
				wall_slow = true;
			}
		} else {
			wall_slow = false;	
		}
	
		x += lengthdir_x(spd, move_direction);
		y += lengthdir_y(spd, move_direction);
	
		#endregion
	
		break; #endregion
		case pStates.move			  : break;
		case pStates.follow_trail	  :	break;
		case pStates.launch_from_trail:	break;
	}


	draw_xscale = lerp(draw_xscale, 1.0, 0.2);
	draw_yscale = lerp(draw_yscale, 1.0, 0.2);

	// update sfx
	if (oCharacter.state != pStates.ghost) {
		//TODO: play end sound
		audio_stop_sound(trail_sound_id);
	} else {
		trail_sound_pitch = trail_sound_pitch_min + trail_sound_pitch_multiply * power(trail_length/trail_length_max, 2);
		audio_sound_pitch(trail_sound_id, trail_sound_pitch);	
		audio_sound_gain(trail_sound_id, global.sound_volume, 0);
	}
}