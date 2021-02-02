
if (global.gamepad_connected) {
	if (keyboard_check_pressed(vk_anykey)) {
		global.gamepad_connected = false;
	}
} else {
	if (gamepad_anykey(global.gamepad_slot, gamepad_threshold_h)) {
		global.gamepad_connected = true;
	}
}

if global.gamepad_connected == true {
	var h_in = gamepad_axis_value(global.gamepad_slot, gp_axislh);
	var v_in = gamepad_axis_value(global.gamepad_slot, gp_axislv);
	var circle_coords = square_to_circle(h_in, v_in);
	
	global.key_right	= (circle_coords[0] > gamepad_threshold_h)*abs(h_in); 
	global.key_left		= (circle_coords[0] <-gamepad_threshold_h)*abs(h_in);
															
	global.key_up		= (circle_coords[1] <-gamepad_threshold_v)*abs(v_in);
	global.key_down     = (circle_coords[1] > gamepad_threshold_v)*abs(v_in);
	
	global.key_jump		= gamepad_button_check_pressed(global.gamepad_slot, gp_face1);
	global.key_interact = gamepad_button_check_pressed(global.gamepad_slot, gp_face3) or gamepad_button_check_pressed(global.gamepad_slot, gp_shoulderrb) or gamepad_button_check_pressed(global.gamepad_slot, gp_shoulderlb);
	
	if (global.key_right) {
		if (pad_right_p == false) {
			pad_right_p = true;
			global.key_right = false;
			global.key_right_p = true;
		}
	} else {
		pad_right_p = false;
	}
	
	if (global.key_left) {
		if (pad_left_p == false) {
			pad_left_p = true;
			global.key_left = false;
			global.key_left_p = true;
		}
	} else {
		pad_left_p = false;
	}
} else {
	global.key_right = keyboard_check(vk_right) or keyboard_check(ord("D"));
	global.key_left = keyboard_check(vk_left) or keyboard_check(ord("A"));
	global.key_up = keyboard_check(vk_up) or keyboard_check(ord("W"));
	global.key_down = keyboard_check(vk_down) or keyboard_check(ord("S"));
	global.key_jump = keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"));
	global.key_interact = keyboard_check_pressed(ord("X")) or keyboard_check_pressed(ord("j")) or keyboard_check_pressed(vk_lshift);

	global.key_right_p = keyboard_check_pressed(vk_right) or keyboard_check_pressed(ord("D"));
	global.key_left_p  = keyboard_check_pressed(vk_left)  or keyboard_check_pressed(ord("A"));
}