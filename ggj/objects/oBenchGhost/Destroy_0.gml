/// @description Insert description here
// You can write your code in this editor
with oMusic {
	audio_stop_sound(track_id);
	audio_stop_sound(muffled_track_id);
	audio_stop_sound(wobbly_track_id);
	instance_destroy();	
}

oCharacter.has_ghost = true;
		
instance_create_depth(0,0,0,oMusic);