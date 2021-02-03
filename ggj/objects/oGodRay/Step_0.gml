/// @description Insert description here
// You can write your code in this editor

image_angle = 0.505*dsin(current_time*0.2);

if (oCharacter.y < 320) {
	image_xscale = oCharacter.y/320	
	image_yscale = image_xscale;
	
	if (image_xscale < 0.1) {
		instance_destroy();	
	}
}