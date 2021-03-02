/// @description 

if (place_meeting(x,y,oGhost)) {
	if instance_exists(oGhost) {
		with oGhost {
			event_perform(ev_step, 0)
		
			max_spd = in_red_spd;
		
			//if (trail_length_max == trail_length_max_init) {
				trail_length_max++;;
			//}
		}
	}

	
	if (!hit_by_ghost) {
		hit_magnitude = hit_magnitude_max;
		hit_by_ghost = true;
				create_hit_particles();

		
	}
	
	if instance_exists(oGhost) {
		hit_magnitude = max(hit_magnitude, 50);
		hit_point_x = oGhost.x;
		hit_point_y = oGhost.y;
	}
} else {
	
	
	
	
	if (hit_by_ghost and instance_exists(oGhost)) {
		hit_magnitude = hit_magnitude_max*0.5*oGhost.spd;
		hit_point_x = oGhost.x;
		hit_point_y = oGhost.y;
		
		create_hit_particles();
	}
	
	hit_by_ghost = false;
}

if (place_meeting(x,y,oCharacter)) {
	if (!hit_by_player) {
		hit_magnitude = hit_magnitude_max;
		hit_by_player = true;
		hit_point_x = global.active_player_object.x;
		hit_point_y = global.active_player_object.y;
				create_hit_particles();

	}
} else {
	

	
	
	if (hit_by_player) {
		hit_magnitude = hit_magnitude_max*0.5*min(1, point_distance(0,0,global.active_player_object.hsp, global.active_player_object.vsp));
		hit_by_player = false;
		hit_point_x = global.active_player_object.x;
		hit_point_y = global.active_player_object.y;
				create_hit_particles();

	}
}

hit_magnitude = lerp(hit_magnitude, 0, 0.1);

if (hit_magnitude < 1) hit_magnitude = 0;