/// @description 
mask_index = sPlayerHitbox;

if creator_player_object.state == pStates.death or creator_player_object.state == pStates.husk {
	
	
	instance_destroy();
	
	rotated_instance_create(x,y,0,0,depth-1,fxEnd);
	exit;	
}


if (go_back) {
	image_index = 1;
	
	if (trail_sound_id == noone) {
		trail_sound_id = audio_play_sound(Stretch_Loop_Reversed, 0, true);
		audio_sound_gain(trail_sound_id, global.sound_volume, 0);
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
		creator_player_object.state = pStates.move;
		//oCamera.zoom = 0.9*oCamera.target_zoom;
		oCamera.screenshake = 4;
		scr_freeze(10);
		show_debug_message("destroyed");
		audio_stop_sound(trail_sound_id);
		instance_destroy();
	}
} else {
	switch creator_player_object.state {
		case pStates.husk: 
		case pStates.death: #region
	
		instance_destroy(oGhostTrail);
		instance_destroy();		
	
		break; #endregion
		case pStates.ghost			  : #region
	
		#region create new trail object
		this_frame = !this_frame;
	
		if (this_frame) {
			var trail_new = instance_create_depth(x,y,depth,oGhostTrail);
	
			var forgiveness_time = 20 * (max_spd+1-spd);
			with trail_new {
				image_xscale = 0;
				image_yscale = 0;
				forgiveness = forgiveness_time;
			}
	
			if trail_previous != noone {
				trail_previous.next = trail_new;
			}
		
			trail_new.creator_player_object = creator_player_object;
		
			trail_new.prev = trail_previous;
			trail_previous = trail_new;
		
			trail_length++;
		}
	
		if (trail_length >= trail_length_max and !go_back) {
			spd = 0;
			
			scr_freeze(40)
			creator_player_object.state = pStates.follow_trail;
			oCamera.screenshake += 5;
			play_sound(choose(Shoot_01, Shoot_02, Shoot_03), 0, false, 1.0, 0.02, global.sound_volume);
			audio_stop_sound(trail_sound_id);
		}
	
		#endregion
	
		x += lengthdir_x(spd, move_direction+270-global.down_direction);
		y += lengthdir_y(spd, move_direction+270-global.down_direction);
	
		#region check for collision
		
		var husk = instance_place(x,y,oCharacter);
		if (husk != noone and husk != creator_player_object) {
			// turn current player to husk
			global.active_player_object.go_to_husk = true;
			global.active_player_object.state = pStates.move;
			
			// activate husk
			husk.state = pStates.move;
			global.active_player_object = husk;
			
			#region unfuck
			var angle_change_since_init = round(-((global.down_direction-husk.draw_angle+720-270) mod 360) + 180);
			if (abs(angle_change_since_init) == 90) { 
				with global.active_player_object {
					var prev = image_angle;
					image_angle = 270-global.down_direction
					obj_unfuck(angle_change_since_init);	
					image_angle = prev;
				}
			} else if (abs(angle_change_since_init) == 180 or abs(angle_change_since_init) == 0) {
				with (global.active_player_object) {
					var prev = image_angle;
					image_angle = 270-global.down_direction
					obj_unfuck(180);	
					image_angle = prev;
				}
			}
			#endregion
			
			// make sure jump doesnt get cancelled
			with husk {
				vsp = -1;
				move_with_physics();
			}
			husk.vsp -= husk.jump_accel;

			// destroy self
			instance_destroy();
	
			rotated_instance_create(x,y,0,0,depth-1,fxEnd);
		}
		
		var red = place_meeting(x,y,oGhostWarpZone);
		if (!red) {
			max_spd = default_max_spd;
		}
		
		var lever = instance_place(x,y,oFlipLever);
		if (lever) {
			// bonk as normal
			destroy_self();
			
			play_sound(Ghost_Hit_Wall, 0, false, 0.8, 0.02, global.sound_volume*1.2);
			
			// rotate
			scr_freeze(40);
			lever.orientation *= -1;
			
			with oGame {
				rotate_world(180);	
			}	
		}
		
		var cog = instance_place(x,y,oCog);
		if (cog) {
			scr_freeze(40);
			// bonk as normal
			destroy_self();
			
			play_sound(Ghost_Hit_Wall, 0, false, 0.8, 0.02, global.sound_volume*1.2);
			
			// get direction
			var dir = angle_difference(move_direction,cog.image_angle)+270-global.down_direction;
			if (sign(dsin(dir)) == 1) {
				with oGame {
					rotate_world(-90);	
				}
				oCog.target_angle -= 90;
			} else if (sign(dsin(dir)) == -1) {
				with oGame {
					rotate_world(90);	
				}
				oCog.target_angle += 90;
			}
		}		
		
		var bonk = instance_place(x,y,oBonkBlock);
		if (bonk) {
			scr_freeze(40);
			// apply impulse
			var dir = move_direction;
			var h_impulse = lengthdir_x(bonk.bonk_impulse, dir);
			var v_impulse = lengthdir_y(bonk.bonk_impulse, dir);
			if (bonk.lock_directions) {
				if (abs(h_impulse) > abs(v_impulse)) {
					bonk.hsp = bonk.bonk_impulse*sign(h_impulse);
					bonk.vsp = 0;
				} else {
					bonk.hsp = 0;
					bonk.vsp = bonk.bonk_impulse*sign(v_impulse);
				}
			} else {
				bonk.hsp += h_impulse;
				bonk.vsp += v_impulse;
			}
			oCamera.screenshake += 5;
			
			// bonk as normal
			destroy_self();
			
			play_sound(Ghost_Hit_Wall, 0, false, 0.8, 0.02, global.sound_volume*1.2);
			
		}
		
		if	(place_meeting(x,y,oWall) or place_meeting(x,y,pHazard)) {
			destroy_self();
			
			play_sound(Ghost_Hit_Wall, 0, false, 1.0, 0.02, global.sound_volume*1.2);
		}
		
		var inst = instance_place(x,y,oLaser);
		if (inst and inst.active) {
			//destroy_self();		
			
			if (audio_is_playing(trail_sound_id)) {
				audio_stop_sound(trail_sound_id);	
			}
			
			creator_player_object.state = pStates.death;
			play_sound(Self_Zapped_by_Laser, 50, false, 1.0, 0.02, global.sound_volume);
	//show_debug_message(string(oLaser.img_index));

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
		turn_direction = global.key_left - global.key_right;
		var turn_direction_pressed = global.key_left_p - global.key_right_p;
		
		if (place_meeting(x,y,oGhostWarpZone)) {
			move_direction = angle_lerp(move_direction, move_direction + turn_direction * in_red_turn_speed, in_red_turn_lerp);	
		} else {
			move_direction = angle_lerp(move_direction, move_direction + turn_direction * turn_speed, turn_lerp);
		}
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
	
		#endregion
	
		break; #endregion
		case pStates.move			  :
		case pStates.follow_trail	  :
		case pStates.launch_from_trail:
		arrows_enabled = lerp(arrows_enabled, 0, 0.2);
		spd = 0;
		spd = 0;
		break;
	}


	draw_xscale = lerp(draw_xscale, 1.0, 0.2);
	draw_yscale = lerp(draw_yscale, 1.0, 0.2);

	// update sfx
	if (creator_player_object.state != pStates.ghost) {
		audio_stop_sound(trail_sound_id);
		
		if (!played_end_sound) {
			play_sound(End_of_Ghost_Dash, 0, false, 1.0, 0.05, global.sound_volume);
			played_end_sound = true;
		}
	} else {
		trail_sound_pitch = trail_sound_pitch_min + trail_sound_pitch_multiply * power(trail_length/trail_length_max, 2);
		audio_sound_pitch(trail_sound_id, trail_sound_pitch);	
		audio_sound_gain(trail_sound_id, global.sound_volume, 0);
	}
}