/// @description Record Gif

if (keyboard_check_pressed(ord("G")))
{
	gifRecord = !gifRecord;
	
	if (gifRecord) //Start recording gif
	{
		gif = gif_open(640,640);
	}
	else //Save gif
	{
		gif_save(gif,"capture.gif");
	}
	
}


if (gifRecord)
{
	gif_add_surface(gif,application_surface,2,0,0,2);
}