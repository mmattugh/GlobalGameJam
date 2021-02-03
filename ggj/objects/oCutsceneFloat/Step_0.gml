
if (place_meeting(x,y,oCharacter)) {
	if (!did_float) {
		instance_create_depth(0,0,0,oMusic);
		oMusic.track_index = SELF_TITLE_SCREEN_LOOP;
		oMusic.muffled_track_index = SELF_TITLE_SCREEN_LOOP;
	
		oCharacter.state = pStates.cutscene_float;
	
		did_float = true;
	
		instance_create_depth(x,0,oCharacter.depth,oCutsceneHand);
		// unlock medals
		//if (NG_MODE) {
		//	ng_unlockmedal("benched");	
		//}
	}
}