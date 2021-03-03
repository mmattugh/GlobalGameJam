/// @description Insert description here
// You can write your code in this editor
draw_set_halign(fa_middle);
draw_set_valign(fa_bottom);

if (white_time > 0) {
	draw_set_color(global.colors.white);	
} else {
	draw_set_color(global.colors.red);	
}

draw_text_transformed(x,y,str, image_xscale, image_yscale, image_angle);

draw_set_halign(fa_left);
draw_set_valign(fa_top);