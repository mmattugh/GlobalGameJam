/// @description 
instance_destroy(oGhostTrail);

if (audio_is_playing(Stretch_Loop)) {
	audio_stop_sound(Stretch_Loop);
}

if (audio_is_playing(Stretch_Loop_Reversed)) {
	audio_stop_sound(Stretch_Loop_Reversed);
}