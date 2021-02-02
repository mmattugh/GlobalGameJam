life--;
if (life == 0) {
	instance_destroy();
}

// remove hitbox after a frame or two
if (image_index > 1) {
	mask_index = sNothing;	
	active = false;
}

img_index += img_spd;

image_index = floor(img_index);