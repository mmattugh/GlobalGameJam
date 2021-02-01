/// @description 

if (oCharacter.combo > 15) {
	// create spikes	
	if (!made_spikes) {
		for (var i = 16; i < room_width-16; i+= 16) {
			
			
			with instance_create_depth(i+16, 32, depth, pHazard) {
				image_angle = 180;	
			}
			
			with instance_create_depth(i, 16, depth-1, fxLand) {
				image_angle = 180;	
			}
		}
		made_spikes = true;
	}
}

if (oCharacter.combo > 50) {
	// create lasers	
	if (!made_lasers) {
		for (var i = 0; i <= 64; i+= 64) {
			instance_create_depth(16, 192+i, depth, oLaserSpawner);
			instance_create_depth(16, 192+i+16, depth, oLaserSpawner);

		}	
		
		for (var i = 0; i < 64; i+= 64) {
			var inst = instance_create_depth(room_width-16, 192+48+i, depth, oLaserSpawner);
			inst.image_angle = 180;
			inst = instance_create_depth(room_width-16, 192+48+i+16, depth, oLaserSpawner);
			inst.image_angle = 180;
		}
		
		made_lasers = true;
	}
}