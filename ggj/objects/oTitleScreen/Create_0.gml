/// @description 
page = 0;
pages = 2;

delay = 0;

selected[0] = 0;
selected_max[0] = 1;

x_offsets = array_create(4, 0);

selected[1] = 0;
selected_max[1] = 3;

text_x = 192;
text_y = 192;
text[0][0] = "press x to start";
text[0][1] = "options";

function update_text() {
	text[1][0] = "back";
	text[1][1] = "screenshake";
	text[1][2] = "music";
	text[1][3] = "sound";

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


red = make_color_rgb(225, 229, 206);
white = make_color_rgb(201, 99, 99);
