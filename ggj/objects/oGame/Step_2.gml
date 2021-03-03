if (global.game_world_paused > 0) {
	instance_activate_object(oGetsPaused);
	
	with (oGetsPaused) {
		try {
			image_speed = __paused_last_image_speed__;		
		} catch (e) {
		}
	}
	
	global.game_world_paused--;
} else if (global.game_world_paused > -1) {
	global.game_world_paused--;
}