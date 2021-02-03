/// @description Insert description here
// You can write your code in this editor
switch state {
	case 0:
	y = oCutsceneHand.y;
	x = approach(x, oCutsceneFloat.x-8, 1);
	
	if (place_meeting(x,y,oCharacter)) {
		delay--;
		
		if (delay <= 10) {
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
		state = 2;	
	}
	break;
	case 2:
	image_index = 1;
	x = approach(x, oCutsceneFloat.x - 30, 30/70);
	y = approach(y, oCutsceneHand.y - 70, 1);
	break;
}