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
	break;
	case 1:	
	if (instance_exists(oCharacter)) {
		oCharacter.state = pStates.freeze;
	}
	
	if (delay > 0) {
		delay--;
		exit;
	}
	
	timer = approach(timer, 0, timer_step);
	
	if (timer == 0) {
		if (instance_exists(oCharacter)) {
			oCharacter.state = pStates.move;
		}
		
		if !instance_exists(oMusic) {
			if room != level_1 and room != level_intermission and room != level_flick {
				instance_create_depth(0,0,0,oMusic);	
			}
		}
		
		instance_destroy();
	}
	break;
}