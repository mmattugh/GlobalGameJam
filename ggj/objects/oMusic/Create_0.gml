/// @description

#region level music data
level_music[level_1] = SELF_OST;
level_music[level_2_1] = SELF_OST;
level_music[level_2_2] = SELF_OST;
level_music[level_2] = SELF_OST;
level_music[level_4] = SELF_OST;
level_music[level_laser_1] = SELF_OST;
level_music[level_laser_1_2_2] = SELF_OST;

level_music[level_intermission] = Facetime_the_Spacetime_Loop;

level_music[level_3_1] = Facetime_the_Spacetime_Loop;
level_music[level_3] = Facetime_the_Spacetime_Loop;
level_music[level_laser_1_2_3] = Facetime_the_Spacetime_Loop;
level_music[level_laser_1_2] = Facetime_the_Spacetime_Loop;
level_music[level_teach_fall] = Facetime_the_Spacetime_Loop;
level_music[level_block_1] = Facetime_the_Spacetime_Loop;
level_music[level_8] = Facetime_the_Spacetime_Loop;
level_music[level_5] = Facetime_the_Spacetime_Loop;
level_music[level_8_5] = Facetime_the_Spacetime_Loop;
level_music[level_6] = Facetime_the_Spacetime_Loop;

level_music[level_flick] = Facetime_the_Spacetime_Loop;

wobbly_music_version[SELF_OST] = SELF_MUFFLED;
muffled_music_version[SELF_OST] = SELF_MUFFLED;

wobbly_music_version[Facetime_the_Spacetime_Loop] = Facetime_the_Spacetime_Muffled;
muffled_music_version[Facetime_the_Spacetime_Loop] = Facetime_the_Spacetime_Muffled;

wobbly_music_version[SELF_TITLE_SCREEN_LOOP] = SELF_TITLE_SCREEN_LOOP;
muffled_music_version[SELF_TITLE_SCREEN_LOOP] = SELF_TITLE_SCREEN_LOOP;

#endregion

try  {
	track_index = level_music[room];
	muffled_track_index = muffled_music_version[track_index];
	wobbly_track_index = wobbly_music_version[track_index];
} catch (e) {
	track_index = SELF_OST;
	muffled_track_index = SELF_MUFFLED;
	wobbly_track_index = SELF_MUFFLED;
}

track_id = noone;
muffled_track_id = noone;
wobbly_track_id = noone;
muffle = 0;

fade_in_time = 1; 
fade_out_time = 1; // 1.5 seconds

fade_in = false;
fade_out = false;
fade_timer = 0;

track_pitch = 1.0;
target_pitch = 1.0;

volume = 0;

forgiveness_time = 5;
forgiveness_timer = forgiveness_time;