if (state = pStates.death)
{
	if room == level_endless {
		if (NG_ENABLED) {
			newgrounds_postscore("9962", global.active_player_object.combo);

		}
	}
	
	room_restart();	
}