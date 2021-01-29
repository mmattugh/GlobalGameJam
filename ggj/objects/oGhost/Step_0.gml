/// @description 

switch oCharacter.state {
	case pStates.ghost			  : #region
	
	#region create new trail object
	this_frame = !this_frame;
	
	if (this_frame) {
		var trail_new = instance_create_layer(x,y,layer,oGhostTrail);
	
		var forgiveness_time = 40 * (max_spd+1-spd);
		with trail_new {
			image_xscale = 0;
			image_yscale = 0;
			forgiveness = forgiveness_time;
		}
	
		if trail_previous != noone {
			trail_previous.next = trail_new;
		}
		
		trail_previous = trail_new;
		
		trail_length++;
	}
	
	if (trail_length >= trail_length_max) {
		scr_freeze(60)
		oCharacter.state = pStates.follow_trail;
		oCamera.screenshake += 5;
	}
	
	#endregion
	
	#region check for collision
	if	(place_meeting(x,y,oWall)) {
		destroy_self();
	}
	
	var inst = instance_place(x,y,oGhostTrail);
	if (inst != noone and inst.forgiveness <= 0) {
		if (immune_timer <= 0) {
			//destroy_self();
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
