
if (global.gamepad_connected) {
	if (keyboard_check_pressed(vk_anykey)) {
		global.gamepad_connected = false;
	}
} else {
	if (gamepad_anykey(global.gamepad_slot, gamepad_threshold_h)) {
		global.gamepad_connected = true;
	}
}

#region the monster
// loop through keys
var binding;
for (var i = input_keys.right; i < input_keys.size; i++) {	
	// reset
	input_state[i] = 0;
	
	// get binding
	check_binding(i);
}
#endregion

// set globals for wide usage
global.key_right		= input_state[input_keys.right];
global.key_left			= input_state[input_keys.left];
global.key_jump			= input_state[input_keys.jump];
global.key_up			= input_state[input_keys.up];
global.key_down			= input_state[input_keys.down];
global.key_interact		= input_state[input_keys.interact];
global.key_right_p		= input_state[input_keys.right_p];
global.key_left_p		= input_state[input_keys.left_p];
global.key_exit			= input_state[input_keys.escape];
global.key_restart		= input_state[input_keys.restart];
