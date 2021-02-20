global.animationSpeed = 0;

#macro DEV_MODE false
#macro dev:DEV_MODE true

#macro NG_ENABLED false
#macro NG:NG_ENABLED true

#macro ITCH_ENABLED false
#macro ITCH:ITCH_ENABLED true

#macro SAVE_FILE "config.ini"

global.camera_width = 320;
global.camera_height = 320;
global.camera_set_window_size = false;


global.rooms = 0;
last_room = noone;
// load values
ini_open(SAVE_FILE);

global.screenshake_intensity = ini_read_real("config", "screenshake_intensity", 1.0);
global.sound_volume			 = ini_read_real("config", "sound_volume", 0.7);
global.music_volume			 = ini_read_real("config", "music_volume", 0.3);
global.speedrun				 = ini_read_real("config", "speedrun", 0.0);

ini_close();
	
global.speedrun_time = 0;

global.screen_freeze_max = 100;
global.screen_freeze_this_frame = 0;

global.made_laser_noise_this_frame = false;

draw_set_font(fFont);
white = make_color_rgb(225, 229, 206);
red = make_color_rgb(201, 99, 99);

if (NG_ENABLED) {
	//ng_connect("51458:SUgrUedz", "GsvSPZWGdzOE8GIpCV3yjOUAhG9E2pn8");
	//ng_initialize_medals_and_scoreboard();
	
	newgrounds_create_core("51458:SUgrUedz");
	
	// used to submit scores to leaderboard
	//ng_postScore("Flick-Time", global.speedrun_time*1000/60);
	//ng_postScore("Combo", combo);
	
	// used to unlock a given medal for a player
	//ng_unlockmedal("medal_name_here");
}