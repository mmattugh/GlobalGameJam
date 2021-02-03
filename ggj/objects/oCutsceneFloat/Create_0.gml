depth = depth+1;
if (instance_exists(oMusic)) {
	with oMusic {
		audio_stop_sound(track_id);
		audio_stop_sound(muffled_track_id);
		audio_stop_sound(wobbly_track_id);
		instance_destroy();
	}
}

did_float = false;