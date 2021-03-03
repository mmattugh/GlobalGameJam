/// @description Insert description here
// You can write your code in this editor
visible = true;

if (global.active_player_object.state == pStates.cutscene_flicked) {
	y = lerp(y, 640, 0.3);	
} else {
	if (global.active_player_object.x > 640) {
		if (global.active_player_object.state == pStates.ghost) {
			y = lerp(y, oGhost.y - sprite_height/2, 0.5);
		} else if (global.active_player_object.state == pStates.follow_trail) {

		} else {
			y = lerp(y, global.active_player_object.y - sprite_height/2, 0.5);	
		}
	}
}