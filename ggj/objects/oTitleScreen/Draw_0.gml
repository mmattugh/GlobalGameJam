
var w = string_width("m");
for (var i = 0; i <= selected_max[page]; i++) {
	var xx = text_x;
	var yy = text_y + i * string_height("M");
	
	if (i == selected[page]) {
		draw_set_color(red);
	} else {
		draw_set_color(white);
	}
	
	for (var j = 0; j < string_length(text[page][i]); j++) {
		draw_text(xx + j*w + 1*dcos(current_time*0.4 + j*30 + i*90), yy + 2*dsin(current_time*0.2 + j*30 + i*90), string_char_at(text[page][i], j+1));
	}
}	
draw_set_color(c_white);