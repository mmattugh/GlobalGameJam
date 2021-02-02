/// @description 

instance_create_depth(0,0,0,oMusic);
oMusic.track_index = SELF_TITLE_SCREEN_LOOP;
oMusic.muffled_track_index = noone;

page = 0;
pages = 3;
delay = 0;

ini_open(SAVE_FILE);
target_room = ini_read_real("save", "latest_room", noone);
ini_close();

if (target_room == noone or global.speedrun) {
	selected[0] = 0;
	selected_max[0] = 3;
	selected[1] = 0;
	selected_max[1] = 4;
	if (global.speedrun) {
		selected_max[1] = 5;
	}
} else {
	selected[0] = 0;
	selected_max[0] = 3;
	selected[1] = 0;
	selected_max[1] = 5;
}

selected[2] = 0;
selected_max[2] = 3;

text[2][0] = "back";
text[2][1] = "dev_dwarf";
text[2][2] = "mmatt_ugh";
text[2][3] = "connor grail";

x_offsets = array_create(6, 0);

text_x = 192;
text_y = 500;

update_text = function() {
	text[1][0] = "back";
	text[1][1] = "screenshake";
	text[1][2] = "music";
	text[1][3] = "sound";
	text[1][4] = "speedrun";

	if global.screenshake_intensity > 0 {
		text[1][1] += ": y";
	} else {
		text[1][1] += ": n";
	}

	if global.music_volume > 0 {
		text[1][2] += ": y";
	} else {
		text[1][2] += ": n";
	}

	if global.sound_volume > 0 {
		text[1][3] += ": y";
	} else {
		text[1][3] += ": n";
	}
	
	if global.speedrun > 0 {
		text[1][4] += ": y";
	} else {
		text[1][4] += ": n";
	}
	
	if global.gamepad_connected and global.gamepad_is_xbox == false {
		text[0][0] = "press square ";	
	} else {
		text[0][0] = "press x ";
	}	
	
	if (target_room == noone or global.speedrun) {
		text[0][0] += "to start";
		
		if (global.speedrun) {
			text[1][5] = "delete save file";
		}
	} else {
		text[0][0] += "to continue";
	
		text[1][5] = "delete save file";
	}
	
	text[0][1] = "endless";
	text[0][2] = "options";
	text[0][3] = "credits";
}

update_text();


red = make_color_rgb(225, 229, 206);
white = make_color_rgb(201, 99, 99);
