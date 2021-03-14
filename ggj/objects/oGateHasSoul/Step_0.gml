/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if (has_soul) {
	if (light == noone) {
		light = instance_create_depth(x+sprite_width/2,y+sprite_width/2,0,oLight);
		with light {
			radius = 30;
			color = make_color_rgb(20, 20, 20);
		}
	}
	
	img_index += .1;
	if (ceil(img_index) == image_number)
	{
		img_index = 1;
	}
} else {
	img_index = 0;
}

image_index = floor(img_index);