/// @description 
depth = depth+1;
if (instance_exists(oMusic)) {
	instance_destroy(oMusic);
}

made_music_obj = false;
red = make_color_rgb(201, 99, 99);

text_y = y;
text_x = x;

alarm[0] = 2;
