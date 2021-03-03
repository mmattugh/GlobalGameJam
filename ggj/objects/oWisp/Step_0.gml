/// @description 


switch state {
	
	case 0:
	
	//x += random_range(-1, 1);
	y -= up_speed;
	image_angle = 90;
	
	up_speed = approach(up_speed, 0, up_speed_decel);
	if (up_speed == 0) state = 1;
	break; 
	
	case 1:
	image_angle = angle_lerp(image_angle, point_direction(x,y,global.active_player_object.x,global.active_player_object.y-8), 0.25);
	direction = image_angle;

	spd = approach(spd, spd_max, 0.07);
	//var x_lerp = abs(lengthdir_x(spd, direction));
	//var y_lerp = abs(lengthdir_y(spd, direction));

	//x = lerp(x, oCharacter.x, x_lerp);
	//y = lerp(y, oCharacter.y-8, y_lerp);
	
	x = lerp(x, global.active_player_object.x, 0.01);
	y = lerp(y, global.active_player_object.y, 0.01);
	
	x += lengthdir_x(spd, direction);
	y += lengthdir_y(spd, direction);


	if place_meeting(x,y,global.active_player_object) {
		play_sound(Self_Wisp_Collect, 50, false, 1.0, 0.02, global.sound_volume);

		instance_destroy();
	}
	break;
}