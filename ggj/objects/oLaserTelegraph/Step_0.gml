life--;
if (life == 0) {
	instance_destroy();	
}

img_index += img_spd;

image_index = floor(img_index);