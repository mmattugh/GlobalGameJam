/// @description Insert description here
// You can write your code in this editor
oCamera.y = (y + oCharacter.y)/2;
switch state {
	case 0:
	var target_y = oCharacter.y
	y = approach(y, target_y, 2);
	
	if (y == target_y) {
		state = 1;
		image_index = 2;
		spd = 0;
		
		oCharacter.state = pStates.cutscene_grabbed;
	}
	break;
	case 1:
	y = approach(y, 80, 2);
	oCharacter.y = y;
	
	if (y == 80) {
		//show_message("made");
		instance_create_depth(640, y, depth-2, oCutsceneHand2);
		state = 2;
	}
	break;
		
}

spd = lerp(spd, 2, 0.1);
