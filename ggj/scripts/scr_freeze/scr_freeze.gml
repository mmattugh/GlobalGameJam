function scr_freeze(argument0) {
	var _freezedur = argument0;
	var _t = current_time + min(_freezedur, global.screen_freeze_max-global.screen_freeze_this_frame);

	while (current_time < _t)
	{
			// do input buffering during freeze frames
		with oController {
			if global.gamepad_connected == true {
				global.key_jump		= global.key_jump	  or gamepad_button_check_pressed(global.gamepad_slot, gp_face1);
				global.key_interact = global.key_interact or gamepad_button_check_pressed(global.gamepad_slot, gp_face3) or gamepad_button_check_pressed(global.gamepad_slot, gp_shoulderrb) or gamepad_button_check_pressed(global.gamepad_slot, gp_shoulderlb);
			} else {
				global.key_jump     = global.key_jump     or keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"));
				global.key_interact = global.key_interact or keyboard_check_pressed(ord("X")) or keyboard_check_pressed(ord("J")) or keyboard_check_pressed(vk_lshift);		
			}	
		}
	};


}
