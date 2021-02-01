/// @description 
draw_set_font(fFontCombo);

if combo >= 3 {
	var c1, c2, s;
	if combo >= 5 {
		c1 = red;
		c2 = black;
		
		s = 1.0 + 0.1*combo;
	} else {
		c1 = white;
		c2 = black;
		s = 1.0
	}
	
	if combo_just_now > 0 {
		combo_just_now--;
		
		s += combo_just_now*0.4;
	}

	s += combo_sin * 0.2;
	
	//draw_set_color(c2);
	//for (var i = 0; i < 4; i++) {
	//	draw_text_transformed(x + 8 + dcos(i*90), y + dsin(i*90), string(combo) + "x" + combo_exclamations, s, s, -35 + 5 * combo_sin);
	//}
	
	draw_set_color(c1);
	draw_text_transformed(x + 8, y, string(combo) + "x" + combo_exclamations, s, s, -35 + 5 * combo_sin);


	draw_set_color(c_white);

}