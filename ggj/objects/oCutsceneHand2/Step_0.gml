/// @description Insert description here
// You can write your code in this editor
switch state {
	case 0:
	y = oCutsceneHand.y - 14;
	x = approach(x, oCutsceneFloat.x+8, 1);
	
	if (place_meeting(x,y,oCharacter)) {
		delay--;
		
		if (delay <= 20 && delay > 18) {
			oCamera.screenshake = 12;
			repeat(25) {
				instance_create_depth(global.active_player_object.x+random_range(-12, 12), global.active_player_object.y - 6 + random_range(-12, 12), depth+1, choose(fxSmoke, fxSmokeLarge, fxSmoke));	
			}
		}
		
		if (delay == 25) {
			play_sound(Hand_put_Face, 0, false, 1.0, 0, global.sound_volume);	
		}
		
		if (delay <= 0) {
			global.active_player_object.sprite_index = sCharacter_Happy;
			state = 1;
		}
	}
	
	break;	
	case 1:
	x = approach(x, oCutsceneFloat.x-50, 0.6);
	
	if (x == oCutsceneFloat.x-50) {
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
	x = approach(x, oCutsceneFloat.x + 40, 30/70);
	y = approach(y, oCutsceneHand.y - 70, 1);
	
	if (x == oCutsceneFloat.x + 40)
	and(y == oCutsceneHand.y - 70) {
		if (delay2 > 0) {
			delay2--;
		} else {
			state = 3;
		}
	}
	break;
	case 3:
	x = approach(x, oCutsceneFloat.x + 33, 0.05);
		oCamera.zoom = zoom;

	if (x == oCutsceneFloat.x + 33) {
		image_index = 0;
		oCamera.zoom = 0.9;
		oCamera.screenshake = 25;
		
		global.active_player_object.state = pStates.cutscene_flicked;
		
		play_sound(Flick, 0, false, 1.0, 0, global.sound_volume);	

		
		if (NG_ENABLED) {
			//ng_unlockmedal("flicked");	
			newgrounds_unlockmedal("62016")
		}
		
		instance_create_depth(0, 0, 0, oCreditsScroll);
		
		state = 4;
	}
	break;
	case 4:
	x = approach(x, oCutsceneFloat.x + 42, 6);
	break;
	
}

if (state != 4 ) {
	oCamera.y = lerp(oCamera.y, y, 0.2);	
}