/// @description 

timer--;

if (timer == 0) {
	var target_x = x;
	var target_y = y;
	
	do {
		instance_create_depth(target_x,target_y,depth-1,oLaser);
		
		target_x += lengthdir_x(16, image_angle);
		target_y += lengthdir_y(16, image_angle);
		
		// TODO: laser create sfx
		
	} until(place_meeting(target_x,target_y,oWall));
	
	timer = frequency;
}