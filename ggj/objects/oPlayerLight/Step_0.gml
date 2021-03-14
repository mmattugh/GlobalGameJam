/// @description Insert description here
// You can write your code in this editor
radius = lerp(radius, target_radius, 0.5);

if (global.active_player_object.state == pStates.ghost)
or (global.active_player_object.state == pStates.follow_trail) 
{
	if (instance_exists(oGhost)) {
		x = oGhost.x;
		y = oGhost.y;
	}
} else {
	x = global.active_player_object.x;
	y = global.active_player_object.y-8;	
	
	if (global.active_player_object.has_ghost == false) {
		radius = 0;	
	}
}