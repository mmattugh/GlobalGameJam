/// @description 
depth = depth+1;
if (instance_exists(oMusic)) {
	with oMusic {
		audio_stop_sound(track_id);
		audio_stop_sound(muffled_track_id);
		audio_stop_sound(wobbly_track_id);
		instance_destroy();
	}
}

made_music_obj = false;
red = make_color_rgb(201, 99, 99);

text_y = y;
text_x = x;

alarm[0] = 2;
