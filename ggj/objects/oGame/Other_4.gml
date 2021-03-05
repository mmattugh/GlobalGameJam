/// @description Insert description here
// You can write your code in this editor
if (last_room != room) {
	last_room = room;
	global.rooms++;
	
	if (COOL_MATH_ENABLED) {
		if (room != title_screen and room != init and room != test_controls) {
			coolmathCallLevelStart(room-test_room);
		}
	}
}
global.down_direction = 270;
