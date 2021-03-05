global.animationSpeed += 0.15;

if global.speedrun and !(global.game_world_paused) and (instance_exists(oCharacter) and global.active_player_object.state != pStates.freeze and !instance_exists(oCutsceneHand)) {
	global.speedrun_time++;
}

// exit run in speedrun mode
if (global.speedrun && global.key_exit) {
	with instance_create_depth(x,y,0,oRoomTransition) {
		target_room = title_screen;
		play_sound(Ghost_Hit_Wall, 0, false, 1.0, 0.02, global.sound_volume);
	}
}

// restart
if (global.key_restart) {
	if (room != level_intermission) {
		room_restart();	
	
		if (COOL_MATH_ENABLED) {
			coolmathCallLevelRestart(room-test_room);
		}
	}
	
}