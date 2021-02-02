/// @description

// handle muffle
if (instance_exists(oGhost)) {
	muffle = true;	
} else {
	muffle = false;	
}

// handle html5
if (track_index != noone and track_id != noone and !audio_is_playing(track_id)) {
	if (forgiveness_timer < 0) {
		// forces us to play the track again
		track_id = noone;	
		forgiveness_timer = forgiveness_time;
	} else {
		forgiveness_timer--;
	}
}

// we have a track to play, but aren't playing it
if (track_index != noone and track_id == noone) {
	
	// if there's just one music manager
	if (instance_number(object_index) == 1) {
		track_id = play_sound(track_index, 100, true, 1.0, 0, global.music_volume);
		muffled_track_id = play_sound(muffled_track_index, 100, true, 1.0, 0, global.music_volume);
		wobbly_track_id = play_sound(wobbly_track_id, 100, true, 1.0, 0, global.music_volume);
		fade_in = true;
	} else {
		// are they playing the same track as us?
		var inst = instance_furthest(x,y,object_index);
		
		if (inst.track_index == track_index) {
			// dont need this object
			instance_destroy();	
		} else {
			// fade out the other instance
			inst.fade_out = true;
			track_id = play_sound(track_index, 100, true, 1.0, 0, global.music_volume);
			muffled_track_id = play_sound(track_index, 100, true, 1.0, 0, global.music_volume);
			wobbly_track_id = play_sound(wobbly_track_id, 100, true, 1.0, 0, global.music_volume);
			fade_in = true;
		}		
	}
}

if (fade_out) {
	volume -= 1/fade_out_time;
	
	if (volume <= 0) {
		audio_stop_sound(track_id);
		audio_stop_sound(muffled_track_id);
		audio_stop_sound(wobbly_track_id);
		instance_destroy();
	}
	
} else if (fade_in) {
	
	volume += 1/fade_in_time;
}


if (track_pitch != target_pitch) {
	track_pitch = lerp(track_pitch, target_pitch, 0.3);

	audio_sound_pitch(track_id, track_pitch);	
	audio_sound_pitch(muffled_track_id, track_pitch);	
		audio_sound_pitch(wobbly_track_id, track_pitch);	

}

audio_sound_gain(track_id, volume*global.music_volume*(1-muffle), 0);
audio_sound_gain(muffled_track_id, volume*global.music_volume*muffle, 0);
audio_sound_gain(wobbly_track_id, volume*global.music_volume*muffle, 0);
