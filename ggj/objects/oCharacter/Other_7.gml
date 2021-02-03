if (state = pStates.death)
{
	if room == level_endless {
		if (NG_MODE) {
			// TODO: save endless highscore	
			ng_postScore("Combo", oCharacter.combo);
		}
	}
	
	room_restart();	
}