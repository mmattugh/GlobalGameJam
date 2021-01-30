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
	image_angle = angle_lerp(image_angle, point_direction(x,y,oCharacter.x,oCharacter.y-8), 0.15);
	direction = image_angle;

	spd = approach(spd, spd_max, 0.07);
	//var x_lerp = abs(lengthdir_x(spd, direction));
	//var y_lerp = abs(lengthdir_y(spd, direction));

	//x = lerp(x, oCharacter.x, x_lerp);
	//y = lerp(y, oCharacter.y-8, y_lerp);
	x += lengthdir_x(spd, direction);
	y += lengthdir_y(spd, direction);


	if place_meeting(x,y,oCharacter) {
		// TODO: wisp collect sfx
	
		instance_destroy();
	}
	break;
}