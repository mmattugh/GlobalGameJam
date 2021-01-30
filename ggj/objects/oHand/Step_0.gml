
if (y != end_y) && (!goback)
{
	y = lerp(y,end_y,0.01);
}
else y = lerp(y,start_y,0.02);

if (global.key_interact) && (!goback)
{
	instance_create_depth(x,y,0,oCharacter);
	instance_create_depth(0,0,0,oCamera);
	image_index = 1;
	goback = true;

}

