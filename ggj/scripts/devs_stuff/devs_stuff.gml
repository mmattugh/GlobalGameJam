///@desc angle_lerp
///@param in
///@param target
///@param percent
function angle_lerp(argument0, argument1, argument2) {
	var angle = (argument0 - angle_difference(argument0, argument1) * argument2)

	while(angle < 0) angle+=360;
	while(angle >= 360) angle -= 360;

	return angle;
}

///@desc approach
///@param in
///@param target
///@param difference
function approach(argument0, argument1, argument2) {
	var start, ending, difference, result;
	start = argument0;
	ending = argument1;
	difference = argument2;
	if (start < ending){
	    result = min(start + difference, ending);
	} else {
	    result = max(start - difference, ending);
	}
	return result;
}


///@param percent
function chance(argument0) {
	return (random(100) <= argument0);
}

///@desc play_sound
function play_sound() {
	var _sound		= argument[0];///@param id
	var _priority	= argument[1];///@param priority
	var _loop		= argument[2];///@param loops
	
	if (_sound == noone) {
		show_debug_message("invalid sound id");
		return noone;	
	}
	
	// optional params
	var _id = audio_play_sound(_sound, _priority, _loop);
	var _modify_pitch = argument_count > 3;
	if (_modify_pitch) {
		var _pitch			= argument[3];///@param pitch?
		var _pitch_variance	= argument[4];///@param variance?
		audio_sound_pitch(_id, _pitch + random_range(-_pitch_variance, _pitch_variance))	
	}
	var _modify_gain = argument_count > 5;
	if (_modify_gain) {	
		var _gain = argument[5];  ///@param gain?

		var _affected_by_distance = argument_count > 6; ///@param distance?
														///@param range?
		if (_affected_by_distance) _affected_by_distance = _affected_by_distance and argument[6];
		
		if (_affected_by_distance) _gain *= max(0, 1-distance_to_object(oCharacter)/argument[7]);

		audio_sound_gain(_id, _gain * audio_sound_get_gain(_id), 0);
	}
	return _id;
}

//@param steps
function steps_to_time(steps) {
	var hour = 0;
	while (steps > 60*60*60) {
		steps -= 60*60*60;
		hour++;
	}
	
	var minute = 0;
	while (steps > 60*60) {
		steps -= 60*60;
		minute++;
	}
	
	var second = 0;
	while (steps > 60) {
		steps -= 60;
		second++;
	}
	
	var out = "";
	if hour != 0 {
		out += string(hour) + ":";	
	}
	if minute != 0 {
		if (minute < 10) {
			out += "0";	
		}
		out += string(minute) + ":";	
	}
	
	if (second < 10) {
		out += "0";	
	}
	out += string(second) + ":";	

	
	if (steps < 10) {
		out += "0";	
	}
	out += string(steps);
	return out;
}

function square_to_circle(x, y) {
	return [
		x * sqrt(1 - y*y / 2),
		y * sqrt(1 - x*x / 2)
	];
}

///@desc gamepad_anykey
///@param slot
function gamepad_anykey(argument0, deadzone) {
	for ( var i = gp_face1; i < gp_axisrv; i++ ) {
	    if ( gamepad_button_check( argument0, i ) ) return i;
	}

	if (abs(gamepad_axis_value(argument0, gp_axislh) > deadzone) or
		abs(gamepad_axis_value(argument0, gp_axislv) > deadzone) or 
		abs(gamepad_axis_value(argument0, gp_axisrh) > deadzone) or 
		abs(gamepad_axis_value(argument0, gp_axisrv) > deadzone)) {
		return true;	
	}
	return false;
}

///@desc remove_underscores
///@param str
function remove_underscores(str) {
	return string_replace_all(str, "_", " ");	
}