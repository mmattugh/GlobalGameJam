/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

red_light = instance_create_depth(x,y,0,oLight);
with red_light {
	radius = 150;
	intensity = 1.0;
	color = make_color_rgb(255, 120, 120);
}

bright_light = instance_create_depth(x,y,0,oLight);
with bright_light {
	radius = 13;
	intensity = 1.0;
	color = make_color_rgb(255, 255, 255);
}