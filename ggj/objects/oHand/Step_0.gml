
if (y != end_y) && (!goback)
{
	y = lerp(y,end_y,0.01);
}
else y = lerp(y,start_y,0.02);

if (global.key_interact) && (!goback)
{
	image_index = 1;
	goback = true;
	instance_create_depth(x,y,0,oCharacter);
	instance_create_depth(x,y,0,oCamera);
}

