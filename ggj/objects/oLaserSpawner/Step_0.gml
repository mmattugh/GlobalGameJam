/// @description 
timer--;

if (timer-laser_telegraph_time == 0) {
	var target_x = x;
	var target_y = y;
	
	if (x > camera_get_view_x(view_camera[0]) and x < camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]))
	and(y > camera_get_view_y(view_camera[0]) and y < camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])) 
	and !global.made_laser_noise_this_frame 
	{
		
		play_sound(Laser_Telegraph, 5, false, 1.0, 0.01, global.sound_volume);
		global.made_laser_noise_this_frame  = true;
	}
	
	do {
		var inst = instance_create_depth(target_x,target_y,depth-1,oLaserTelegraph);
		inst.life = laser_telegraph_time;
		inst.img_spd = inst.image_number/laser_telegraph_time;
		inst.image_angle = image_angle;
		
		target_x += lengthdir_x(16, image_angle);
		target_y += lengthdir_y(16, image_angle);
		
		// TODO: laser create sfx
		
	} until(place_meeting(target_x,target_y,Solid) or place_meeting(target_x,target_y,oBreakableWall));
}

if (timer == 0) {
	var target_x = x;
	var target_y = y;
	
	if (x > camera_get_view_x(view_camera[0]) and x < camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]))
	and(y > camera_get_view_y(view_camera[0]) and y < camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])) 
	and !global.made_laser_noise_this_frame 
	{
		play_sound(Laser_Shoot, 0, false, 1.0, 0.01, global.sound_volume);
		global.made_laser_noise_this_frame  = true;
	}
	
	do {
		var inst = instance_create_depth(target_x,target_y,depth-1,oLaser);
		inst.life = laser_time;
		inst.img_spd = inst.image_number/laser_time;
		inst.image_angle = image_angle;
		
		target_x += lengthdir_x(16, image_angle);
		target_y += lengthdir_y(16, image_angle);
		
		// TODO: laser create sfx
		
	} until(place_meeting(target_x,target_y,Solid) or place_meeting(target_x,target_y,oBreakableWall));
	
	timer = frequency;
}