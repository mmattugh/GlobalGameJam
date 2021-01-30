/// @description 
timer--;

if (timer-laser_telegraph_time == 0) {
	var target_x = x;
	var target_y = y;
	
	do {
		var inst = instance_create_depth(target_x,target_y,depth-1,oLaserTelegraph);
		inst.life = laser_telegraph_time;

		target_x += lengthdir_x(16, image_angle);
		target_y += lengthdir_y(16, image_angle);
		
		// TODO: laser create sfx
		
	} until(place_meeting(target_x,target_y,oWall));
}

if (timer == 0) {
	var target_x = x;
	var target_y = y;
	
	do {
		var inst = instance_create_depth(target_x,target_y,depth-1,oLaser);
		inst.life = laser_time;
		
		target_x += lengthdir_x(16, image_angle);
		target_y += lengthdir_y(16, image_angle);
		
		// TODO: laser create sfx
		
	} until(place_meeting(target_x,target_y,oWall));
	
	timer = frequency;
}