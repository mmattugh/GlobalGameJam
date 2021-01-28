global.key_right = keyboard_check(vk_right) or keyboard_check(ord("D"));
global.key_left = keyboard_check(vk_left) or keyboard_check(ord("A"));
global.key_up = keyboard_check(vk_up) or keyboard_check(ord("W"));
global.key_down = keyboard_check(vk_down) or keyboard_check(ord("S"));
global.key_jump = keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"));
global.key_interact = keyboard_check_pressed(ord("X")) or keyboard_check_pressed(ord("E"));
