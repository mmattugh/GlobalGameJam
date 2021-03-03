/// @description Insert description here
// You can write your code in this editor


switch state {
	case 0:
	oCamera.y = (y + global.active_player_object.y)/2;

	var target_y = global.active_player_object.y
	y = approach(y, target_y, 2);
	
	if (y == target_y) {
		state = 1;
		image_index = 2;
		spd = 0;
		
		global.active_player_object.state = pStates.cutscene_grabbed;
	}
	break;
	case 1:
	y = approach(y, 80, 2);
	
	if (global.active_player_object.state != pStates.cutscene_flicked) {
		//oCamera.y = y
		global.active_player_object.y = y;
	}
	
	if (y == 80) {
		//show_message("made");
		instance_create_depth(150, y, depth-2, oCutsceneHand2);
		state = 2;
	}
	break;
		
}

spd = lerp(spd, 2, 0.1);
