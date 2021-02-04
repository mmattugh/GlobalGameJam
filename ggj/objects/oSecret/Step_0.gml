/// @description Insert description here
// You can write your code in this editor

if place_meeting(x,y,oCharacter) and sprite_index != sSecret2 {
	image_speed = .1;
	sprite_index = sSecret2;
	
	oCamera.screenshake += 8;
	play_sound(Self_Death, 0, false, 0.5, 0, global.sound_volume);
	repeat(25) {
		instance_create_depth(x + random_range(-16, 16), y + random_range(-16, 16), depth-1, choose(fxSmoke,fxSmoke,fxSmokeLarge));
	}
	
	instance_create_depth(624, 368, depth, oRecharge);
	
	play_sound(sndSecretShadow, 0, false, 1.0, 0.0, global.sound_volume);
}	

if (image_speed > 0) image_speed = approach(image_speed, 1, 0.05);
