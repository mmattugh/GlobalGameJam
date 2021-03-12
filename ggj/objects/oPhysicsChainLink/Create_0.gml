/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

angle_offset = 0;

custom_update = function() {
	var c = dsin(angle_offset)
	image_index = (c+1)*image_number*0.5;	
	image_yscale = 0.5*0.5*(1+c)+0.5
}

image_speed = 0;