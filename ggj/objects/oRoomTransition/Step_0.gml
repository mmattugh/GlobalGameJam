/// @description

switch state {
	case 0:
	timer = approach(timer, out_duration, timer_step);
	
	if (timer == out_duration) {
		timer = in_duration;
		state = 1;
		
		if (target_room == noone) {
			room_goto_next();
		} else {
			room_goto(target_room);	
		}
	}
	
	if (instance_exists(global.active_player_object)) {
		global.active_player_object.state = pStates.freeze;
	}
	
	break;
	case 1:	
	if (delay > 0) {
		delay--;
		exit;
	}
	
	timer = approach(timer, 0, timer_step);
	
	if (timer < in_duration/3) {
		if (instance_exists(oCharacter) and global.active_player_object.state == pStates.move) {
			global.active_player_object.state = pStates.move;
		}	
	} else {
		if (instance_exists(oCharacter)) {
			global.active_player_object.state = pStates.freeze;
		}
	}
	
	if (timer == 0) {
		
		if !instance_exists(oMusic) {
			if room != level_1 and room != level_intermission and room != level_flick {
				instance_create_depth(0,0,0,oMusic);	
			}
		}
		
		instance_destroy();
	}
	break;
}