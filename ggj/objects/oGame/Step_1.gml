global.screen_freeze_this_frame = 0;
global.made_laser_noise_this_frame = false;

if(mouse_check_button_pressed(mb_any) or keyboard_check_pressed(vk_anykey)) focus_window();

if (keyboard_check_pressed(ord("L"))) {
	rotate_world(90);
}
if (keyboard_check_pressed(ord("K"))) {
	rotate_world(-90);
}
if (keyboard_check_pressed(ord("I"))) {
	rotate_world(180);
}