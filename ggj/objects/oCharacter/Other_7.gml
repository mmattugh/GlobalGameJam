if (state = pStates.death)
{
	if room == level_endless {
		if (NG_ENABLED) {
			// TODO: save endless highscore	
			//ng_postScore("Combo", oCharacter.combo);
			
			newgrounds_postscore("9962", oCharacter.combo);

		}
	}
	
	room_restart();	
}