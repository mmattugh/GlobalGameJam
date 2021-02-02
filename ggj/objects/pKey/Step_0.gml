
if (variable_global_get(variable)) {
	oCamera.screenshake += 7;
	
	play_sound(Self_Jump, 50, false, 1.0, 0.02, global.sound_volume);

	
	instance_destroy();	
}

var t = current_time*0.5;
image_angle = 6*dsin(t + rand);
image_xscale = 1.0 + 0.2*dsin(t*2 + rand);
image_yscale = 1.0 + 0.2*dsin(t*2 + rand);
