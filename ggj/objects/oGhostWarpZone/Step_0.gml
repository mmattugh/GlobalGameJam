/// @description 

if (place_meeting(x,y,oGhost)) {
	with oGhost {
		event_perform(ev_step, 0)	
		
		if (trail_length_max == trail_length_max_init) {
			trail_length_max *= 2;
		}
	}
	
	
}