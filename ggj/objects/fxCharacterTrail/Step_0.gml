/// @description Fade
if (image_alpha > 0)
{
	image_alpha -= .025;
}
else instance_destroy(self);
