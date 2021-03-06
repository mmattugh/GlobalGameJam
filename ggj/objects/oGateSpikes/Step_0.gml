//if !instance_exists(oWisp) {
	if (instance_number(oSoul) == 0) {
		if (!audio_is_playing(Self_Gate_Destroy)) {
			play_sound(Self_Gate_Destroy, 5, false, 1.0, 0.01, global.sound_volume);
		}
		instance_destroy();	
	}

	if (instance_number(oSoul) != soul_count) {
		if (!audio_is_playing(Self_Gate_Destroy)) {
			play_sound(Gate_Rumble, 40, false, 1.0, 0.02, global.sound_volume);
		}
		
		soul_count--;
		shake = 4;
		repeat (5) {
			with instance_create_depth(x+random_range(0, sprite_width),y+random_range(0, sprite_height),depth-1,choose(fxSmoke,fxSmoke,fxSmokeLarge))
			{
				direction = random_range(75,105)
				speed = random_range(1,3)
			}
		}
	}
//}
shake = lerp(shake, 0, 0.2);