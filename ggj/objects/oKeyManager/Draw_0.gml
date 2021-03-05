/// @description Insert description here
// You can write your code in this editor
if WEB_ENABLED {
	if !clicked {
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		
		var w = string_width("m");
		var h = string_height("M");
		for (var j = 0; j < string_length(text1); j++) {
			draw_text(room_width/2 + j*w + 2*dcos(current_time*0.8 + j*30) - string_width(text1), room_height/2 + dsin(current_time*0.4 + j*30)+ 2.5, string_char_at(text1, j+1));
		}	
		
		for (var j = 0; j < string_length(text2); j++) {
			draw_text(room_width/2 + j*w + 2*dcos(current_time*0.8 + j*30) - string_width(text2), 2*h+room_height/2 + dsin(current_time*0.4 + j*30)+ 2.5, string_char_at(text2, j+1));
		}	
	
		draw_set_halign(fa_top);
		draw_set_valign(fa_left);
	}
}