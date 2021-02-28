/// @description Insert description here
mask_index = sprite_index;
if (!instance_exists(oGhost)) {
	sprite_index = sGhostSpikeBallDown;
	mask_index = sNothing;
	y = ystart + 2*dsin(current_time*0.2+random_offset);
	
	if (floor(image_index) != 0) {
		image_speed = -1;
	} else {
		image_speed = 0;	
	}
} else {
	sprite_index = sGhostSpikeBall;
	y = lerp(y, ystart, 0.5);
	
	if (floor(image_index) != final_frame) {
		image_speed = 1;
	} else {
		image_speed = 0;	
		mask_index = sprite_index;
	}
}