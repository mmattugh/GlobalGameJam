/// @description Insert description here
// You can write your code in this editor
if (!made_music_obj) {
	instance_create_depth(0,0,0,oMusic);
	oMusic.track_index = SELF_TITLE_SCREEN_LOOP;
	oMusic.muffled_track_index = SELF_TITLE_SCREEN_LOOP;
	
	oCharacter.state = pStates.bench;
	
	made_music_obj = true;
	
	
	// unlock medals
	if (NG_MODE) {
		ng_unlockmedal("benched");	
	}
}