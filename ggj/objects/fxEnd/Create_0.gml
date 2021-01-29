oCamera.screenshake += 7;
repeat (10)
{
	with instance_create_depth(x,y,depth+1,fxSmokeLarge)
	{
		direction = random_range(0,360)
		speed = random_range(1,3)
	}
}