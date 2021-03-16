/// @description Insert description here
// You can write your code in this editor
if (last_room != room) {
	last_room = room;
	global.rooms++;
	
	if (COOL_MATH_ENABLED) {
		if (ds_map_exists(cool_math_room_data, room)) {	
			coolmathCallLevelStart(cool_math_room_data[? room]);
		}
	}
}
global.down_direction = 270;
