global.key_right		= 0;
global.key_left			= 0;
global.key_jump			= 0;
global.key_up			= 0;
global.key_down			= 0;
global.key_interact		= 0;
global.key_right_p		= 0;
global.key_left_p		= 0;
global.key_exit			= 0;
global.key_restart		= 0;


enum input_keys {
	right  ,
	left,
	jump,
	up,
	down,
	interact,
	right_p,
	left_p,
	escape,
	restart,
	
	size, // size of this enum, keep this at bottom
}

#region gamepad setup
// gamepad state holders
global.gamepad_connected = false;
global.gamepad_slot = 0;
global.gamepad_is_xbox = true;

// gamepad deadzone constants: TODO: make configurable via options
gamepad_threshold_h = 0.33;
gamepad_threshold_v = 0.6;
#endregion

#region alternative key bindings. TODO: make configurable via options

input_state = array_create(input_keys.size, 0);
input_bindings = array_create(input_keys.size);

enum input_modes {
	held,
	pressed,
	released
}
// creates a new key binding object
key_binding = function(_key_enum, _default_key_binding, _input_mode) constructor {
	// initalize data values
	key_enum = _key_enum;
	
	key_bindings = 1;
	key_binding[0] = _default_key_binding;
	
	gamepad_bindings = 0;
	gamepad_binding[0] = noone;
	
	input_mode = _input_mode;
	
	// define additional functions	
	gamepad_binding_struct = function(_gamepad_binding, _is_axis, _axis_dir) constructor {
		gamepad_binding = _gamepad_binding	;
		is_axis			= _is_axis			;
		axis_dir		= _axis_dir			;
		pressed			=  false			;
	}
	
	add_alternative_binding = function(_key_binding) {
		key_binding[key_bindings++] = _key_binding;
	}
	
	add_gamepad_binding = function(_gamepad_binding, _is_axis, _axis_dir) {
		show_debug_message("created gamepad binding");
		gamepad_binding[gamepad_bindings++] = new gamepad_binding_struct(_gamepad_binding, _is_axis, _axis_dir);
	}
	
}

// create bindings
input_bindings[input_keys.right	  ] = new key_binding(input_keys.right, vk_right, input_modes.held);
input_bindings[input_keys.right	  ].add_alternative_binding(ord("D"));
input_bindings[input_keys.right	  ].add_gamepad_binding(gp_axislh, true, 1);

input_bindings[input_keys.left	  ] = new key_binding(input_keys.left, vk_left, input_modes.held);
input_bindings[input_keys.left	  ].add_alternative_binding(ord("S"));
input_bindings[input_keys.left	  ].add_gamepad_binding(gp_axislh, true, -1);

input_bindings[input_keys.jump	  ] = new key_binding(input_keys.jump, vk_space, input_modes.pressed);
input_bindings[input_keys.jump	  ].add_alternative_binding(vk_up);
input_bindings[input_keys.jump	  ].add_alternative_binding(ord("W"));
input_bindings[input_keys.jump	  ].add_gamepad_binding(gp_face1, false, -1);

input_bindings[input_keys.up	  ] = new key_binding(input_keys.up, vk_up, input_modes.held);
input_bindings[input_keys.up	  ].add_alternative_binding(ord("W"));
input_bindings[input_keys.up	  ].add_gamepad_binding(gp_axislv, true, -1);

input_bindings[input_keys.down	  ] = new key_binding(input_keys.down, vk_down, input_modes.held);
input_bindings[input_keys.down	  ].add_alternative_binding(ord("S"));
input_bindings[input_keys.down	  ].add_gamepad_binding(gp_axislv, true, 1);

input_bindings[input_keys.interact] = new key_binding(input_keys.interact, vk_lshift, input_modes.pressed);
input_bindings[input_keys.interact].add_alternative_binding(ord("X"));
input_bindings[input_keys.interact].add_alternative_binding(ord("J"));
input_bindings[input_keys.interact].add_gamepad_binding(gp_face3, false, -1);
input_bindings[input_keys.interact].add_gamepad_binding(gp_shoulderlb, false, -1);
input_bindings[input_keys.interact].add_gamepad_binding(gp_shoulderrb, false, -1);

input_bindings[input_keys.right_p	  ] = new key_binding(input_keys.right_p, vk_right, input_modes.pressed);
input_bindings[input_keys.right_p	  ].add_alternative_binding(ord("D"));
input_bindings[input_keys.right_p	  ].add_gamepad_binding(gp_axislh, true, 1);

input_bindings[input_keys.left_p	  ] = new key_binding(input_keys.left_p, vk_left, input_modes.pressed);
input_bindings[input_keys.left_p	  ].add_alternative_binding(ord("S"));
input_bindings[input_keys.left_p	  ].add_gamepad_binding(gp_axislh, true, -1);

input_bindings[input_keys.escape  ] = new key_binding(input_keys.escape, vk_escape, input_modes.pressed);
input_bindings[input_keys.escape].add_gamepad_binding(gp_select, false, -1);

input_bindings[input_keys.restart  ] = new key_binding(input_keys.restart, ord("R"), input_modes.pressed);
input_bindings[input_keys.restart].add_gamepad_binding(gp_start, false, -1);

check_binding = function(i) {
	binding = input_bindings[i];	
	// switch based on gamepad use
	if global.gamepad_connected == true {	
		// loop through the assigned bindings
		for (var j = 0; j < binding.gamepad_bindings; j++) {
			// is this binding a joystick?
			if binding.gamepad_binding[j].is_axis {
				// set the appropriate threshold
				var threshold;
				if (binding.gamepad_binding[j].gamepad_binding == gp_axislh) 
				or (binding.gamepad_binding[j].gamepad_binding == gp_axisrh)
				{
					threshold = gamepad_threshold_h;	
				} else {
					threshold = gamepad_threshold_v;
				}	
				
				// get axis values
				var axis_dir = binding.gamepad_binding[j].axis_dir;
				var axis_value = gamepad_axis_value(global.gamepad_slot, binding.gamepad_binding[j].gamepad_binding);
				
			// switch based on type of input, do we hold down, press, or release for this input
				switch (binding.input_mode) {
					case input_modes.held:
					input_state[i] = input_state[i] 
					or ((abs(axis_value) > threshold) and (sign(axis_value) == axis_dir));
					break;
					case input_modes.pressed:
					if ((abs(axis_value) > threshold) and (sign(axis_value) == axis_dir)) {
						if (!binding.gamepad_binding[j].pressed) {
							input_state[i] = true;
							binding.gamepad_binding[j].pressed = true;
						}
					} else {
						binding.gamepad_binding[j].pressed = false;	
					}
					break;
					case input_modes.released:
					// fuck it dont want to deal with this tbh, not sure it has meaning with joysticks
					break;				
				}	
			} else {
			// switch based on type of input, do we hold down, press, or release for this input
				switch (binding.input_mode) {
					case input_modes.held:
					input_state[i] = input_state[i] or gamepad_button_check(global.gamepad_slot, binding.gamepad_binding[j].gamepad_binding);
					break;
					case input_modes.pressed:
					input_state[i] = input_state[i] or gamepad_button_check_pressed(global.gamepad_slot, binding.gamepad_binding[j].gamepad_binding);
					break;
					case input_modes.released:
					input_state[i] = input_state[i] or gamepad_button_check_released(global.gamepad_slot, binding.gamepad_binding[j].gamepad_binding);
					break;				
				}
			}
		}
	} else {
		// loop through the assigned bindings
		for (var j = 0; j < binding.key_bindings; j++) {
		
			// switch based on type of input, do we hold down, press, or release for this input
			switch (binding.input_mode) {
				case input_modes.held:
				input_state[i] = input_state[i] or keyboard_check(binding.key_binding[j]);
				break;
				case input_modes.pressed:
				input_state[i] = input_state[i] or keyboard_check_pressed(binding.key_binding[j]);
				break;
				case input_modes.released:
				input_state[i] = input_state[i] or keyboard_check_released(binding.key_binding[j]);
				break;				
			}
		}
	}
}
#endregion