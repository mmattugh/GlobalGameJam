/// @description Fade
if (image_alpha > 0)
{
	image_alpha -= .025;
	image_angle_offset = lerp(image_angle_offset, 0, 0.1);
	image_angle = image_angle_initial + image_angle_offset;

}
else instance_destroy(self);
