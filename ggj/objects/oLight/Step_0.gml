/// @description Insert description here
// You can write your code in this editor
if (fade_out) {
	radius = lerp(radius, 0, 0.5);
	if (radius < 1) instance_destroy();	
}