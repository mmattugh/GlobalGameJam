
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
global.key_up			= input_state[input_keys.up];
global.key_down			= input_state[input_keys.down];
global.key_right_p		= input_state[input_keys.right_p];
global.key_left_p		= input_state[input_keys.left_p];
global.key_exit			= input_state[input_keys.escape];
global.key_restart		= input_state[input_keys.restart];

// dont update if these hold data from freeze
if (global.game_world_paused > -1) {
	global.key_right		= global.key_right		or   input_state[input_keys.right];
	global.key_left			= global.key_left		or	 input_state[input_keys.left];
	global.key_up			= global.key_up			or   input_state[input_keys.up];
	global.key_down			= global.key_down		or	 input_state[input_keys.down];
	global.key_right_p		= global.key_right_p	or	 input_state[input_keys.right_p];
	global.key_left_p		= global.key_left_p		or   input_state[input_keys.left_p];
	global.key_exit			= global.key_exit		or	 input_state[input_keys.escape];
	global.key_restart		= global.key_restart	or	 input_state[input_keys.restart];
	global.key_jump			= global.key_jump		or	 input_state[input_keys.jump];
	global.key_interact		= global.key_interact	or	 input_state[input_keys.interact];
} else {
	global.key_right		= input_state[input_keys.right];
	global.key_left			= input_state[input_keys.left];
	global.key_up			= input_state[input_keys.up];
	global.key_down			= input_state[input_keys.down];
	global.key_right_p		= input_state[input_keys.right_p];
	global.key_left_p		= input_state[input_keys.left_p];
	global.key_exit			= input_state[input_keys.escape];
	global.key_restart		= input_state[input_keys.restart];
	global.key_jump			= input_state[input_keys.jump];
	global.key_interact		= input_state[input_keys.interact];
}