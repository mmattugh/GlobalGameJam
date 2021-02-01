/// @description Insert description here
// You can write your code in this editor

image_speed = 0.5;
#region move
var target_dir, move_dir;
switch state {
	case 0:
	target_dir = 135;
	move_dir = 1;
	
	turn_lerp = 0.4;
	
	
	trail_scale = lerp(trail_scale, 1.5, 0.05);
	
	if (move_direction == target_dir) state = 1;
	
	break;
	case 1:
	target_dir = 35;
	move_dir = -1;
	
	turn_lerp = 0.4;
	trail_scale = lerp(trail_scale, 3.5, 0.025);
	zoom = lerp(zoom, 2.0, 0.02);
	oCamera.zoom = zoom;

	spd = approach(spd, 0.25, 0.05);
	if (spd == 0.25) state = 2;
	break;
	case 2:
	target_dir = 90;
	move_dir = 1;
	
	turn_lerp = 0.4;
	
	if (move_direction == target_dir) state = 3;

	trail_scale = lerp(trail_scale, 3.75, 0.05);
	zoom = lerp(zoom, 2.5, 0.05);

	oCamera.zoom = zoom;
	break;
	case 3:
	
	zoom = lerp(zoom, 2.5, 0.05);
	
	if (global.key_interact) {
		hit -= 1;
		oMusic.track_pitch += 0.5;
		play_sound(choose(Footsteps_01, Footsteps_02), 50, false, 1.0, 0.05, global.sound_volume);	
		oCamera.screenshake = 9;
		zoom -= 0.1;
	}
	
	if (hit > 1) {
		hit -= 0.01;
		
		if (global.key_left_p) {
			play_sound(choose(Footsteps_01, Footsteps_02), 50, false, 1.0, 0.05, global.sound_volume);	
			oCharacter.x -= 0.5;
			x += 1;
			hit -= 1;
			oMusic.track_pitch += 0.5;
			oCamera.screenshake = 7;
			zoom -= 0.1;
		}
		if (global.key_right_p) {
			play_sound(choose(Footsteps_01, Footsteps_02), 50, false, 1.0, 0.05, global.sound_volume);	
			oCharacter.x += 0.5;
			x -= 1;
			hit -= 1;
			oMusic.track_pitch += 0.5;
			oCamera.screenshake = 7;
			zoom -= 0.1;
		}
	}
	
	
	if (hit <= 0) {
		scr_freeze(15)
		oCharacter.state = pStates.follow_trail;
		//fx
		instance_create_depth(oCharacter.x,oCharacter.y-16,0,fxStart);
		play_sound(choose(Shoot_01, Shoot_02, Shoot_03), 0, false, 0.8, 0.02, global.sound_volume);
		
		state = 4;
	}
	
	
	spd = 0;
	// idk??
	audio_stop_sound(trail_sound_id);
	
	oCamera.zoom = zoom;
	
	
	var c = 2*dcos(current_time*.1)
	var s = 2*dcos(current_time*.2)	
	
	x += c*0.05;
	y += s*0.05;
	
	with oGhostTrail {
		x = xstart + c
		y = ystart + s

	}
	
	exit;
	break;
	
	case 4:
	oCamera.zoom = zoom;
	exit;
	break;
}

#region create new trail object
this_frame = !this_frame;
	
if (this_frame) {
	var trail_new = instance_create_depth(x,y,depth,oGhostTrail);
	
	var forgiveness_time = 20 * (max_spd+1-spd);
	with trail_new {
		image_xscale = 0;
		image_yscale = 0;
		image_scale = other.trail_scale;
		forgiveness = forgiveness_time;
	}
	
	if trail_previous != noone {
		trail_previous.next = trail_new;
	}
		
	trail_new.prev = trail_previous;
	trail_previous = trail_new;
		
	trail_length++;
}
#endregion

if (move_direction != target_dir) {
	move_direction = angle_lerp(move_direction, move_direction + move_dir * turn_speed, turn_lerp);
	
	if (abs(angle_difference(move_direction, target_dir)) <= 2) {
		move_direction = target_dir;	
	}

	spd = approach(spd, max_spd, acceleration);
}
	
x += lengthdir_x(spd, move_direction);
y += lengthdir_y(spd, move_direction);
#endregion

