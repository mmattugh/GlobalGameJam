/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if (has_soul) {
	img_index += .1;
	if (ceil(img_index) == image_number)
	{
		img_index = 1;
	}
} else {
	img_index = 0;
}

image_index = floor(img_index);