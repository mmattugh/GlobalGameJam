/// @description Insert description here
on_ground = place_meeting(x,y+1,Solid);
mask_index = sPlayerHitbox;

#region gameplay state machine
switch state {
	case pStates.move			  : #region
	// goto ghost state
	if (global.key_interact) && (has_ghost) {
		state = pStates.ghost;
		has_ghost = false;
		ghost_regen_timer = ghost_regen_time;
		trail_target = noone;
		trail_target_next = noone;
		
		// set camera values
		oCamera.zoom = 0.9*oCamera.target_zoom;
		oCamera.screenshake += 7;

		with instance_create_layer(x,y-8,layer,oGhost) 
		{
			move_direction = 90;
			global.key_interact = false;
		}
	}
	
	// horizontal speed
	var h_dir = global.key_right - global.key_left;
	
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
		vsp += grav_accel;
		
	}
	
	// jump
	if (global.key_jump) && (on_ground) {
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
	if (global.key_interact) {
		state = pStates.follow_trail;
	}
		
	// rapid decel
	hsp = lerp(hsp, 0, 0.8);
	vsp = lerp(vsp, 0, 0.8);
	
	
	break;							#endregion
	case pStates.follow_trail	  : #region
	oGhost.spd = 0;
	
	// goto launch state
	if (place_meeting(x,y,oGhost)) {
		hsp = 0;
		vsp = 0;
		state = pStates.launch_from_trail;
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
		instance_destroy(trail_target);
		
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
		instance_destroy(oGhost);
		instance_destroy(oGhostTrail);
		state = pStates.move;
		global.key_interact = false;
	}	
	
	break;							#endregion
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
		oCamera.screenshake += 0.1*fall_time;	
	}
	
	fall_time = 0;	
}


switch state {
	// same graphics state for both
	case pStates.move			  : #region
	case pStates.ghost:
	draw_angle = 0;
	if (sign(hsp) != 0) flipped = sign(hsp);
	
	if !on_ground {
		image_speed = 0;
		sprite_index = sCharacter_Air;
		
		if (vsp > 0.2) image_index = 2;
		else if (vsp < -0.2) image_index = 0;
		else image_index = 1;
	} else {
		if (sprite_index == sCharacter_Air) {
			instance_create_depth(x,y,depth+1,fxLand);			
			draw_xscale = 1.3;
			draw_yscale = 0.7;
		}
		
		image_speed = 1;
		if (hsp != 0) {
			sprite_index = sCharacter_Walk;
		} else {
			sprite_index = sCharacter_Idle;
		}
	}
	
	break; #endregion
	case pStates.follow_trail	  : #region
	
	break; #endregion
	case pStates.launch_from_trail: #region
	
	break; #endregion
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
			temp_hsp -= sign_hsp;
			temp_vsp -= sign_vsp;
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
if (on_ground and state == pStates.move)  {
	has_ghost = true;	
}

#endregion