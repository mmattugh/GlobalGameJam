draw_set_font(fFont);
draw_set_halign(fa_left);

var w = string_width("m") - 3;
var xx = text_x;
var yy = text_y;
for (var i = 0; i <= selected_max[page]; i++) {
	yy += string_height("M");
	
	if (i == bonus_level_start) {
		draw_set_color(global.colors.white);
		for (var j = 0; j < string_length(bonus_level_text); j++) {
			draw_text(xx + j*w + 2*dcos(current_time*0.8 + j*30 + i*90) - string_width(bonus_level_text)/2, yy + dsin(current_time*0.4 + j*30 + i*90)+ 2.5, string_char_at(bonus_level_text, j+1));
		}
		yy += string_height("M");
	}
	
	if (i == selected[page]) {
		draw_set_color(global.colors.white);
	} else {
		draw_set_color(global.colors.red);
	}
	
	for (var j = 0; j < string_length(text[page][i]); j++) {
		draw_text(xx + j*w + 1*dcos(current_time*0.4 + j*30 + i*90) + x_offsets[i], yy + 2*dsin(current_time*0.2 + j*30 + i*90)+ x_offsets[i]*0.5, string_char_at(text[page][i], j+1));
	}
}	
draw_set_color(c_white);