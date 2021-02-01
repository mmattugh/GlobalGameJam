/// @description Insert description here
// You can write your code in this editor
if (global.speedrun) {
	draw_set_color(white)
	var s = steps_to_time(global.speedrun_time);
	draw_text(display_get_gui_width()-string_width(s)-8, 8, s);
	draw_set_color(c_white)
}