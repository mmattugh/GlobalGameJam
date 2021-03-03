/// @description Insert description here
// You can write your code in this editor
if (!made_music_obj) {
	if (instance_exists(oMusic)) {
		instance_destroy(oMusic);
	}
}

if (global.active_player_object.state == pStates.bench ) {
	if (instance_exists(oBenchGhost) and oBenchGhost.state == 3) {
		text_y = lerp(text_y, y - 200, 0.2);
	
		if global.key_interact {
			continue_pressed = true;
		}	
	}
} else {
	
	if (text_y < y and !made_particles_2) {
		var w = string_width("m") - 3;
		var xx = text_x + x_offsets[2];
		var yy = text_y + y_offsets[2];
		var scale = scales[2];
		
		for (var j = 0; j < string_length(text[2]); j++) {
			instance_create_depth(xx + j*w*scale + scale*dcos(current_time*0.4 + j*30 + 2*90)
								, yy + scale*2*dsin(current_time*0.2 + j*30 + 2*90)
								, 0,
								fxSmokeLarge);
			}
		
		made_particles_2 = true;
	}
	
	text_y = lerp(text_y, y + 500, 0.6);
}	
