/// @description 

var selected_dir = global.key_down - global.key_up;
var selected_pressed = global.key_interact;

oCamera.zoom = lerp(oCamera.zoom, 1.1, 0.1);
text_x = lerp(text_x , 192, 0.2);
text_y = lerp(text_y , 192, 0.2);

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
			
			var inst = instance_create_depth(0,0,depth,oRoomTransition);
			inst.target_room = target_room;
			
			with oMusic {
				fade_out = true;
				volume = 0;
			}
			// save states
			ini_open(SAVE_FILE);

			ini_write_real("config", "screenshake_intensity", global.screenshake_intensity );
			ini_write_real("config", "sound_volume",  global.sound_volume			 	   );
			ini_write_real("config", "music_volume",  global.music_volume			 	   );

			ini_close();
			break;
			case 1:		
			page = 1;
			
			break;
			case 2:			
			page = 2;
			
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
			case 4:
			global.speedrun = 1-global.speedrun;
			update_text();
			break;
			case 5:
			play_sound(Ghost_Hit_Wall, 0, false, 1.0, 0.02, global.sound_volume);

			if (text[1][5] == "are you sure") {
				file_delete(SAVE_FILE);
				game_restart();
			} else {
				text[1][5] = "are you sure";
			}
			break;
		}

		break;
		case 2:
	
		switch selected[page] {
			case 0:
			
			page = 0;
			
			break;
			case 1:
			url_open_ext("https://twitter.com/dev_dwarf", "_blank");
			break;
			case 2:
			url_open_ext("https://twitter.com/mmatt_ugh", "_blank");
			break;
			case 3:
			url_open_ext("https://twitter.com/ConnorGrail", "_blank");
			break;
		}
		break;
	}
	
	play_sound(Land, 50, false, 1.0, 0.02, global.sound_volume);
	x_offsets = array_create(7, 7);
}

// move camera
var s = 4*dsin(current_time * 0.08);
var c = 2*dcos(current_time * 0.12);
	

switch page {
	case 0:
	oCamera.y = lerp(oCamera.y, room_height/2 + s, 0.4);
	oCamera.x = lerp(oCamera.x, room_width/2 + c, 0.4);
	break;
	case 1:
	oCamera.y = lerp(oCamera.y, room_height+s, 0.4);
	oCamera.x = lerp(oCamera.x, room_width/2 + c, 0.4);
	break;
	case 2:
	oCamera.y = lerp(oCamera.y, room_height/2 + s, 0.4);
	oCamera.x = lerp(oCamera.x, room_width, 0.4);
	break;
}

for (var i = 0; i < 6; i++) {
	x_offsets[i] = lerp(x_offsets[i], 0, 0.2);
}	