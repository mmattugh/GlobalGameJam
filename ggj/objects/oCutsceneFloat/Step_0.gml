if (oCharacter.state == pStates.move) {
	if (place_meeting(x,y,oCharacter)) {
		if (!did_float) {
			instance_create_depth(0,0,0,oMusic);
			oMusic.track_index = SELF_TITLE_SCREEN_LOOP;
			oMusic.muffled_track_index = SELF_TITLE_SCREEN_LOOP;
	
			global.active_player_object.state = pStates.cutscene_float;
			did_float = true;
		
			
			// save beat game
			ini_open(SAVE_FILE);
			ini_write_real("save", "flicked", true);
            
			instance_create_depth(x,0,global.active_player_object.depth,oCutsceneHand);
		
			// save best time
			if (global.speedrun) {
				var prev_best = ini_read_real("save", "best_time", -1);
		
				if (prev_best > global.speedrun_time or prev_best == -1) {
					ini_write_real("save", "best_time", global.speedrun_time);
			
					if (NG_ENABLED) {
						//ng_postScore("Flick-Time", global.speedrun_time*1000/60);
						newgrounds_postscore("9961", global.speedrun_time*1000/60);
			
					}
				}
				
			}
			ini_close();
		}
	}
}