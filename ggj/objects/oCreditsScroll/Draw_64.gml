/// @description 
draw_set_font(fFont);
var w = string_width("m") - 3;
var h = string_height("M");
var xx = display_get_gui_width() * 1/4;
var yy = text_y;
for (var i = 0; i < sections; i++) {
	// draw header
	draw_set_color(global.colors.white);	
	for (var j = 0; j < string_length(header[i]); j++) {
		draw_text(xx + j*w + 1*dcos(current_time*0.4 + j*30 + i*90), yy + 2*dsin(current_time*0.2 + j*30 + i*90), string_char_at(header[i], j+1));
	}
	yy += 2*h;
	
	// draw text + subtext
	draw_set_color(global.colors.red);	
	for (var k = 0; k < array_length(text[i]); k++) {
		for (var j = 0; j < string_length(text[i][k]); j++) {
			draw_text(xx + j*w + 1*dcos(current_time*0.4 + j*30 + i*90), yy + 2*dsin(current_time*0.2 + j*30 + i*90), string_char_at(text[i][k], j+1));
		}
		yy += h;
		
		if (i < array_length(subtext) && is_array(subtext[i])) {
			for (var j = 0; j < string_length(subtext[i][k]); j++) {
				draw_text(xx + j*w + 1*dcos(current_time*0.4 + j*30 + i*90) + 15, yy + 2*dsin(current_time*0.2 + j*30 + i*90), string_char_at(subtext[i][k], j+1));
			}
			yy += h;
		}
		
		yy += h*0.5;
	}
	// draw footer
	for (var j = 0; j < string_length(footer[i]); j++) {
		draw_text(xx + j*w + 1*dcos(current_time*0.4 + j*30 + i*90), yy + 2*dsin(current_time*0.2 + j*30 + i*90), string_char_at(footer[i], j+1));
	}
	yy += 3.5*h;
}	
draw_set_color(c_white);