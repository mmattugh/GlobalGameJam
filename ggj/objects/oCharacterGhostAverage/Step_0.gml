/// @description 
if (instance_exists(oGhost)) {
	x = (global.active_player_object.x*0.25 + oGhost.x*0.75);
	y = (global.active_player_object.y*0.25 + oGhost.y*0.75);
} else if (instance_exists(oCharacter)){
	x = global.active_player_object.x;	
	y = global.active_player_object.y;
}	