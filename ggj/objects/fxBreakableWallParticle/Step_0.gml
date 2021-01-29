/// @description 

speed = lerp(speed, 0, 0.2);

image_angle += random_range(-5, 5);

if (speed < 0.3) {
	instance_destroy();
	instance_create_depth(x,y,depth,fxSmoke);
	
	if (chance(25)) {
		instance_create_depth(x,y,depth,fxSmokeLarge);	
	}	
}