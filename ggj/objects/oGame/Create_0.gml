global.animationSpeed = 0;

#macro DEV_MODE false
#macro dev:DEV_MODE true

#macro NG_MODE false
#macro NG:NG_MODE true

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

if (NG_MODE) {
	ng_connect("51458:SUgrUedz", "GsvSPZWGdzOE8GIpCV3yjOUAhG9E2pn8");
	ng_initialize_medals_and_scoreboard();
	
	// used to submit scores to leaderboard
	//ng_postScore("Flick-Time", global.speedrun_time*1000/60);
	//ng_postScore("Combo", combo);
	
	// used to unlock a given medal for a player
	//ng_unlockmedal("medal_name_here");
}