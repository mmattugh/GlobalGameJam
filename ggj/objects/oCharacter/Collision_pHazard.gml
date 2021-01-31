/// @description
if (state != pStates.death) {
	image_index = 0;
	play_sound(Self_Death, 50, false, 1.0, 0.02, global.sound_volume);
	state = pStates.death;
}