/// @description Insert description here
// You can write your code in this editor

draw_self();

if (text_y < y) {
draw_set_font(fFont);
var w = string_width("m") - 3;
for (var i = 0; i < 3; i++) {
	var xx = text_x + x_offsets[i];
	var yy = text_y + y_offsets[i];
	var scale = scales[i];
	
	if (i < 2 and continue_pressed) {
		if (!made_particles) {
			for (var j = 0; j < string_length(text[i]); j++) {
			instance_create_depth(xx + j*w*scale + scale*dcos(current_time*0.4 + j*30 + i*90)
								, yy + scale*2*dsin(current_time*0.2 + j*30 + i*90)
								, 0,
								fxSmokeLarge);
			}
			
			if (i == 1) made_particles = true;
		}
	} else {
	
		draw_set_color(global.colors.red);
	
		for (var j = 0; j < string_length(text[i]); j++) {
			draw_text_transformed(xx + j*w*scale + scale*dcos(current_time*0.4 + j*30 + i*90)
					, yy + scale*2*dsin(current_time*0.2 + j*30 + i*90)
					, string_char_at(text[i], j+1)
					, scale, scale, angles[i] + 5*dsin(current_time*0.1 + i*90));
		}
	}
}	
draw_set_color(c_white);
}