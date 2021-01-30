//if !instance_exists(oWisp) {
	if (instance_number(oSoul) == 0) {
		// TODO: gate destroy sfx
	
		instance_destroy();	
	}

	if (instance_number(oSoul) != soul_count) {
		// TODO: gate rumble sfx
	
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