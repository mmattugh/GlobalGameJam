/// @description 

if WEB_ENABLED {
	if (!clicked) {
		if (pKey.visible) {
			with pKey {
				visible = false;
			}
		}
		
		if (mouse_check_button(mb_left)) {
			play_sound(Self_Zapped_by_Laser, 50, false, 1.0, 0.02, global.sound_volume);
			clicked = true;
			
			with pKey {
				visible = true;
			}
			
			if (COOL_MATH_ENABLED) {
				coolmathCallStart();	
			}
		}
	}
}


if !instance_exists(pKey) {
	play_sound(Self_Zapped_by_Laser, 50, false, 1.0, 0.02, global.sound_volume);
	room_goto_next();	
}