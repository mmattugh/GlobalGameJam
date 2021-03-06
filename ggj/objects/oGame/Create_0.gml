
#region configuration macros
#macro DEV_MODE false
#macro dev:DEV_MODE true

#macro NG_ENABLED false
#macro NG:NG_ENABLED true

#macro ITCH_ENABLED false
#macro ITCH:ITCH_ENABLED true

#macro COOL_MATH_ENABLED false
#macro COOL_MATH:COOL_MATH_ENABLED true

#macro WEB_ENABLED false
#macro NG:WEB_ENABLED true
#macro ITCH:WEB_ENABLED true
#macro COOL_MATH:WEB_ENABLED true

#macro SAVE_FILE "config.ini"

#macro LIGHTING_ENABLED true
#macro NG:LIGHTING_ENABLED false
#macro ITCH:LIGHTING_ENABLED false
#macro COOL_MATH:LIGHTING_ENABLED false

#endregion

global.animationSpeed = 0;
global.camera_width = 320;
global.camera_height = 320;
global.camera_set_window_size = false;
global.game_world_paused = 0;
global.rooms = 0;

global.oldest_player_object = noone;
global.active_player_object = noone;


last_room = noone;

// load values
ini_open(SAVE_FILE);
global.screenshake_intensity = ini_read_real("config", "screenshake_intensity", 1.0);
global.sound_volume			 = ini_read_real("config", "sound_volume", 0.7);
global.music_volume			 = ini_read_real("config", "music_volume", 0.3);
global.speedrun				 = ini_read_real("config", "speedrun", 0.0);

global.best_combo			 = ini_read_real("save", "best_combo", 3);

if (NG_ENABLED) {
	var send_best_combo = global.best_combo;
	var send_best_pb	= ini_read_real("save", "best_time", -1);
}


ini_close();
	
global.speedrun_time = 0;

global.screen_freeze_max = 100;
global.screen_freeze_this_frame = 0;

global.made_laser_noise_this_frame = false;

draw_set_font(fFont);

global.colors = {
	white	: make_color_rgb(225, 229, 206),
	red		: make_color_rgb(201, 99, 99),
	bg		: make_color_rgb(36, 34, 35),
	blue	: make_color_rgb(69, 91, 105),
};

application_surface_draw_enable(false);
window_set_colour(global.colors.bg);

#region platform specific
if (NG_ENABLED) {
	newgrounds_create_core("51458:SUgrUedz");
	
	if (send_best_combo > 5) {
		newgrounds_postscore("9962", send_best_combo);
	}
	
	if (send_best_pb != -1) {
		newgrounds_postscore("9961", send_best_pb*1000/60);
	}
}

if (COOL_MATH_ENABLED) {
	window_set_caption("SELF [DEMO] – Play it now at CoolmathGames.com");	
	window_set_size(800, 600);
	
	// lock
	#region
	domain = url_get_domain();
	if(domain!="https://www.coolmath-games.com"&&
	domain!="m.coolmathgames.com"&&
	domain!="dev.coolmathgames.com"&&
	domain!="edit-stage.coolmathgames.com"&&
	domain!="www.stage.coolmathgames.com"&&
	domain!="edit.coolmathgames.com"&&
	domain!="www.coolmathgames.com"&&
	domain!="https://www.coolmathgames.com"&&
	domain!="m.coolmath-games.com"&&
	domain!="dev.coolmath-games.com"&&
	domain!="edit-stage.coolmath-games.com"&&
	domain!="www.stage.coolmath-games.com"&&
	domain!="edit.coolmath-games.com"&&
	domain!="www.coolmath-games.com")
	{
		//game_end();
	}
	
	// init level array
	cool_math_room_data = ds_map_create();
	ds_map_add(cool_math_room_data,level_1			  ,  01);
	ds_map_add(cool_math_room_data,level_2			  ,  02);
	ds_map_add(cool_math_room_data,level_3			  ,  03);
	ds_map_add(cool_math_room_data,level_4			  ,  04);
	ds_map_add(cool_math_room_data,level_5			  ,  05);
	ds_map_add(cool_math_room_data,level_6_laser_1	  ,  06);
	ds_map_add(cool_math_room_data,level_7_laser_2	  ,  07);
	ds_map_add(cool_math_room_data,level_8_laser_3	  ,  08);
	ds_map_add(cool_math_room_data,level_intermission , 09);
	ds_map_add(cool_math_room_data,level_9			  , 10);
	ds_map_add(cool_math_room_data,level_10			 , 11);
	ds_map_add(cool_math_room_data,level_11_laser_4	 , 12);
	ds_map_add(cool_math_room_data,level_12_teach_fall, 13);
	ds_map_add(cool_math_room_data,level_13_block_1	, 14);
	ds_map_add(cool_math_room_data,level_14_block_2	, 15);
	ds_map_add(cool_math_room_data,level_15_tall	, 16);
	ds_map_add(cool_math_room_data,level_16_block_3	, 17);
	ds_map_add(cool_math_room_data,level_17_block_4	, 18);
	ds_map_add(cool_math_room_data,level_flick		, 19);
	ds_map_add(cool_math_room_data,level_bonus_1	, 20);
	ds_map_add(cool_math_room_data,level_bonus_2	, 21);
	ds_map_add(cool_math_room_data,level_bonus_3	, 22);
	ds_map_add(cool_math_room_data,level_bonus_4	, 23);
	ds_map_add(cool_math_room_data,level_bonus_5	, 24);
	ds_map_add(cool_math_room_data,level_endless	, 25);
	
	#endregion
} else {
	window_set_caption("SELF [DEMO]");
}

#endregion

instance_create_depth(0,0,0,oLightingManager);

// define functions
rotate_world = function(amount) {
	global.down_direction = (global.down_direction + amount + 360) mod 360;
	oCamera.angle_offset = (oCamera.angle_offset + amount + 360) mod 360;
	
	with global.active_player_object {
		obj_unfuck(amount);	
	}
	
	
}