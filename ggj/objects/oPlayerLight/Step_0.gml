/// @description Insert description here
// You can write your code in this editor
if (global.active_player_object.state == pStates.ghost)
or (global.active_player_object.state == pStates.follow_trail) 
{
	if (instance_exists(oGhost)) {
		x = oGhost.x;
		y = oGhost.y;
	}
} 
else if (global.active_player_object.has_ghost = true)
{
x = global.active_player_object.x;
y = global.active_player_object.y-8;	
}
else 
{
	x = -3200
	y = -3200
}