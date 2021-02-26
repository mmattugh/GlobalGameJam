/// @description 

instance_create_depth(0,0,0,oMusic);
oMusic.track_index = SELF_TITLE_SCREEN_LOOP;
oMusic.muffled_track_index = noone;

page = 0;
pages = 3;
delay = 0;

global.speedrun_time = 0;

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
text[2][1] = "mmatt_ugh";
text[2][2] = "dev_dwarf";
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
		
		ini_open(SAVE_FILE);
		var best_time = ini_read_real("save", "best_time", -1);
		ini_close();
		
		if (best_time != -1) {
			text[1][4] += " " + steps_to_time(best_time);	
		}
	} else {
		text[1][4] += ": n";
	}
	
	if global.gamepad_connected and global.gamepad_is_xbox == false {
		text[0][0] = "press square ";	
	} else {
		text[0][0] = "press x ";
	}	
	
	ini_open(SAVE_FILE);
	target_room = ini_read_real("save", "latest_room", noone);
	ini_close();
	
	if (target_room == noone or global.speedrun) {
		text[0][0] += "to start";
		
		if (global.speedrun) {
			text[1][5] = "delete save file";
		}
		target_room = level_1;
	} else {
		text[0][0] += "to continue";
	
		text[1][5] = "delete save file";
	}
	
	text[0][1] = "endless";
	text[0][2] = "options";
	text[0][3] = "credits";
}
	
save_options_state = function() {
// save states
ini_open(SAVE_FILE);

ini_write_real("config", "screenshake_intensity", global.screenshake_intensity );
ini_write_real("config", "sound_volume",  global.sound_volume			 	   );
ini_write_real("config", "music_volume",  global.music_volume			 	   );
ini_write_real("config", "speedrun",  global.speedrun			 	   );

ini_close();	
}

update_text();

