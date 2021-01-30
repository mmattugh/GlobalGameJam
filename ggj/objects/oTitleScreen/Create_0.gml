/// @description 
page = 0;
pages = 2;

delay = 0;

selected[0] = 0;
selected_max[0] = 1;

selected[1] = 0;
selected_max[1] = 3;

text_x = 160;
text_y = 240;
text[0][0] = "Press X to start";
text[0][1] = "Options";

function update_text() {
	text[1][0] = "Back";
	text[1][1] = "Screenshake";
	text[1][2] = "Music";
	text[1][3] = "Sound";

	if global.screenshake_intensity > 0 {
		text[1][1] += ": Y";
	} else {
		text[1][1] += ": N";
	}

	if global.music_volume > 0 {
		text[1][2] += ": Y";
	} else {
		text[1][2] += ": N";
	}

	if global.sound_volume > 0 {
		text[1][3] += ": Y";
	} else {
		text[1][3] += ": N";
	}
}

update_text();


white = make_color_rgb(225, 229, 206);
red = make_color_rgb(201, 99, 99);
