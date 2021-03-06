/// @description 

if (global.active_player_object.state == pStates.ghost and instance_exists(oBackToTitle)) {
	instance_destroy(oBackToTitle);
	instance_create_depth(144, 288, depth, pHazard);
	instance_create_depth(160, 288, depth, pHazard);
	instance_create_depth(144+8, 288+16, depth-1, fxLand)
	instance_create_depth(160+8, 288+16, depth-1, fxLand)
}

if (global.active_player_object.combo > 15) {
	if !destroyed_recharges	{
		destroyed_recharges = true;	
		
		oCamera.screenshake += 7;
		
		instance_activate_object(oRecharge);
		var inst = instance_nearest(0,0,oRecharge);
		if (inst != noone) {
			instance_create_depth(inst.x, inst.y, 0, fxEnd);
			instance_destroy(inst);
		}
	
		var inst = instance_nearest(room_width,0,oRecharge);
		if (inst != noone) {
			instance_create_depth(inst.x, inst.y, 0, fxEnd);
			instance_destroy(inst);
		}
		
		var inst = instance_nearest(room_width/2, 0, oRecharge);
		if (inst != noone) {
			inst.target_ystart -= 48;
			inst.state = recharge.enabled
		}
		
		var inst = instance_nearest(0, room_height, oRecharge);
		if (inst != noone) {
			inst.target_ystart -= 16;
			inst.state = recharge.enabled
		}
	
		var inst = instance_nearest(room_width, room_height, oRecharge);
		if (inst != noone) {
			inst.target_ystart -= 16;
			inst.state = recharge.enabled
		}

	}
}

if (global.active_player_object.combo > 25) {
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

if (global.active_player_object.combo > 50) {
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