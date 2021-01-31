/// @description 

var selected_dir = global.key_down - global.key_up;
var selected_pressed = global.key_interact;

// set selected
if (delay > 0) {
	delay--;
	selected_dir = 0;
}

if (selected_dir != 0) {
	delay = 15;
	play_sound(Footsteps_01, 50, false, 1.0, 0.02, global.sound_volume);

	selected[page] += selected_dir;

	if (selected[page] < 0) {
		selected[page] = selected_max[page];	
	}
	if (selected[page] > selected_max[page]) {
		selected[page] = 0;	
	}
	
	x_offsets[selected[page]] = 10;
}

// handle press
if (selected_pressed) {	
	switch page {
		case 0:
	
		switch selected[page] {
			case 0:
			
			instance_create_depth(0,0,depth,oRoomTransition);
			
			break;
			case 1:
			
			page = 1;
			
			break;
		}
	
		break;
		case 1:
	
		switch selected[page] {
			case 0:
			
			page = 0;
			
			break;
			case 1:
			
			global.screenshake_intensity = 1-global.screenshake_intensity;
			update_text();
			
			break;
			case 2:
			
			if global.music_volume > 0 {
				global.music_volume = 0;
			} else {
				global.music_volume = 0.5;
			}			
			update_text();
			
			break;
			case 3:
			
			if global.sound_volume > 0 {
				global.sound_volume = 0;
			} else {
				global.sound_volume = 0.7;
			}
			update_text();
			
			break;
		}
	
		break;
	}
	
	play_sound(Land, 50, false, 1.0, 0.02, global.sound_volume);
	x_offsets = array_create(4, 7);
}

// move camera
var s = 4*dsin(current_time * 0.08);
var c = 2*dcos(current_time * 0.12);
	oCamera.x = room_width/2 + c;

switch page {
	case 0:
	oCamera.y = lerp(oCamera.y, room_height/2 + s, 0.4);
	break;
	case 1:
	oCamera.y = lerp(oCamera.y, 2*room_height/2+s, 0.4);
	break;
}

for (var i = 0; i < 4; i++) {
	x_offsets[i] = lerp(x_offsets[i], 0, 0.2);
}	