/// @description 

if (instance_exists(oBenchGhost)) {
	if (oBenchGhost.state == 3) {
		if (delay > 0) {
			delay--;
		} else {
			y = approach(y, ystart+sprite_height-100, 1);	
		}
		exit;
	}
}

y = lerp(y, ystart, 0.3);