/// @description Insert description here
// You can write your code in this editor
if (global.active_player_object.state == pStates.move) {
	if (!made_music_obj) {
		instance_create_depth(0,0,0,oMusic);
		oMusic.track_index = SELF_TITLE_SCREEN_LOOP;
		oMusic.muffled_track_index = SELF_TITLE_SCREEN_LOOP;
	
		global.active_player_object.state = pStates.bench;
	
		made_music_obj = true;
	
	
		// unlock medals
		if (NG_ENABLED) {
			//ng_unlockmedal("benched");	
			newgrounds_unlockmedal("62017")
		}
	
	}
}