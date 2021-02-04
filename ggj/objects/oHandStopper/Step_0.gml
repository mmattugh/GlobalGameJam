/// @description Insert description here
// You can write your code in this editor

if (oCharacter.state == pStates.cutscene_flicked) {
	y = lerp(y, 640, 0.3);	
} else {
	if (oCharacter.x > 640) {
		if (oCharacter.state == pStates.ghost) {
			y = lerp(y, oGhost.y - sprite_height/2, 0.5);
		} else if (oCharacter.state == pStates.follow_trail) {

		} else {
			y = lerp(y, oCharacter.y - sprite_height/2, 0.5);	
		}
	}
}