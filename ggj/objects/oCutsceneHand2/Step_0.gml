/// @description Insert description here
// You can write your code in this editor
switch state {
	case 0:
	y = oCutsceneHand.y;
	x = approach(x, oCutsceneFloat.x-8, 1);
	
	if (place_meeting(x,y,oCharacter)) {
		delay--;
		
		if (delay <= 20) {
			repeat(15) {
				instance_create_depth(oCharacter.x+random_range(-12, 12), oCharacter.y - 6 + random_range(-12, 12), depth+1, choose(fxSmoke, fxSmokeLarge, fxSmoke));	
			}
		}
		
		if (delay <= 0) {
			oCharacter.sprite_index = sCharacter_Happy;
			state = 1;
		}
	}
	
	break;	
	case 1:
	x = approach(x, oCutsceneFloat.x+50, 0.6);
	
	if (x == oCutsceneFloat.x+50) {
		if (delay1 > 0) {
			delay1--;
		} else {
			state = 2;	
		}
	}
	break;
	case 2:
	//zoom = lerp(zoom, 1.5, 0.1);
	oCamera.zoom = zoom;
	
	image_index = 1;
	x = approach(x, oCutsceneFloat.x - 40, 30/70);
	y = approach(y, oCutsceneHand.y - 70, 1);
	
	if (x == oCutsceneFloat.x - 40)
	and(y == oCutsceneHand.y - 70) {
		if (delay2 > 0) {
			delay2--;
		} else {
			state = 3;
		}
	}
	break;
	case 3:
	x = approach(x, oCutsceneFloat.x - 33, 0.05);
		oCamera.zoom = zoom;

	if (x == oCutsceneFloat.x - 33) {
		image_index = 0;
		oCamera.zoom = 0.9;
		oCamera.screenshake = 15;
		
		oCharacter.state = pStates.cutscene_flicked;
		
		state = 4;
	}
	break;
	case 4:
	x = approach(x, oCutsceneFloat.x - 42, 6);
	break;
	
}