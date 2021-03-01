/// @description 

orientation = 1;
transition_time = 12;
image_speed = 0;

// spawn collider
var inst = instance_create_depth(x+lengthdir_x(16,image_angle), y+lengthdir_x(16,image_angle), 0, oWall);
inst.image_xscale = 1;
inst.image_yscale = 1;