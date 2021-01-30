
if (keyboard_check_pressed(key))
or (keyboard_check_pressed(key_alt)) {
	// TODO: some sort of sfx
	oCamera.screenshake += 7;
	instance_destroy();	
}

var t = current_time*0.5;
image_angle = 6*dsin(t + key + key_alt);
image_xscale = 1.0 + 0.2*dsin(t*2 + key + key_alt);
image_yscale = 1.0 + 0.2*dsin(t*2 + key + key_alt);
