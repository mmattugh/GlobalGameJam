/// @description 

if !instance_exists(pKey) {
	play_sound(Self_Zapped_by_Laser, 50, false, 1.0, 0.02, global.sound_volume);
	room_goto_next();	
}