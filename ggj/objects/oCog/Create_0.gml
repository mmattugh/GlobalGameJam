/// @description Insert description here
// You can write your code in this editor


target_angle = global.down_direction;
image_angle = target_angle;
angle_speed = 0.4;

// spawn collider
var inst = instance_create_depth(x-16, y-16, 0, oWall);
inst.image_xscale = 2;
inst.image_yscale = 2;

