/// @description 

image_xscale = lerp(image_xscale, 1.0, 0.4);
image_yscale = lerp(image_yscale, 1.0, 0.4);

if (forgiveness > 0) {
	forgiveness--;	
	
	if (forgiveness <= 0) {
		mask_index = sprite_index;	
	}
}