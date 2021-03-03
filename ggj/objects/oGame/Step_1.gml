global.screen_freeze_this_frame = 0;
global.made_laser_noise_this_frame = false;

if(mouse_check_button_pressed(mb_any) or keyboard_check_pressed(vk_anykey)) focus_window();

if (DEV_MODE) {
	if (keyboard_check_pressed(ord("L"))) {
		rotate_world(90);
	}
	if (keyboard_check_pressed(ord("K"))) {
		rotate_world(-90);
	}
	if (keyboard_check_pressed(ord("I"))) {
		rotate_world(180);
	}
	if (keyboard_check_pressed(ord("M"))) {
		global.game_world_paused = 30;	
	}
}


if (global.game_world_paused > 0) {
	with oGetsPaused {
		__paused_last_image_speed__ = image_speed;	
	}
	instance_deactivate_object(oGetsPaused);
} 