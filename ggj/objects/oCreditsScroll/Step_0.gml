/// @description Insert description here
// You can write your code in this editor

text_y-=0.3+global.key_down*2;

if (text_y < 2 && text_y > 0) {
	header[0] = "a gate by";
} else {
	header[0] = "a game by";	
}

if (text_y < -160) {
	if (global.key_interact) {
		room_goto(title_screen);
	}	
}