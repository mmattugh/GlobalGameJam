/// @description Insert description here
// You can write your code in this editor

if (image_index > image_number - 1.5) {
	image_speed = 0;	
	exit;
}
if place_meeting(x,y,oCharacter) and image_speed != 1 {
	image_speed = 1;
	
	play_sound(sndSecretPlayerGrassFootstep, 0, false, 1.0, 0.0, global.sound_volume);
}	
