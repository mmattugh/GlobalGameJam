/// @description 

//if (oCharacter.death_restart_delay < oCharacter.death_restart_delay_max) {
if (oCharacter.state == pStates.death) {
	draw_clear(bg_color);
	
	with oCharacter {
		event_perform(ev_draw, 0);	
	}
	
	with fxParent {
		event_perform(ev_draw, 0);	
	}
}