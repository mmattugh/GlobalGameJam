/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if (has_soul) {
	image_index += .1;
	if (ceil(image_index) == image_number)
	{
		image_index = 1;
	}
} else {
	image_index = 0;
}