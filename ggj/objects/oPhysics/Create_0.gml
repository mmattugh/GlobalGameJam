/// @description Insert description here
// You can write your code in this editor
near_screen = function() {
	return (true
	&& (x > oPhysics.view_x1)
	&& (x < oPhysics.view_x2)
	&& (y > oPhysics.view_y1)
	&& (y < oPhysics.view_y2)
	)
}

physics_wind_magnitude = 0.05;
physics_wind = 0;

depth = oCharacter.depth+2;