/// @description 

if WEB_ENABLED {
	if (!clicked) {
		if (instance_exists(pKey)) {
			instance_deactivate_object(pKey);
		}
		
		if (mouse_check_button(mb_left)) {
			play_sound(Self_Zapped_by_Laser, 50, false, 1.0, 0.02, global.sound_volume);
			clicked = true;
			
			instance_activate_object(pKey);
			
			if (COOL_MATH_ENABLED) {
				coolmathCallStart();	
			}
		}
		
		exit;
	}
}


if !instance_exists(pKey) {
	play_sound(Self_Zapped_by_Laser, 50, false, 1.0, 0.02, global.sound_volume);
	room_goto_next();	
}