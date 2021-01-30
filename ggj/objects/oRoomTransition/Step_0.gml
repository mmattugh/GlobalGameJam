/// @description

switch state {
	case 0:
	timer = approach(timer, out_duration, timer_step);
	
	if (timer == out_duration) {
		timer = in_duration;
		state = 1;
		room_goto_next();
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
		
		instance_destroy();
	}
	break;
}