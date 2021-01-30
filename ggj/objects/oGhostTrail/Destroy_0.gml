repeat (5)
{
	with instance_create_depth(x,y,depth+1,fxSmoke)
	{
		direction = random_range(0,360)
		speed = random_range(1,3)
	}
}

with instance_create_depth(x,y,depth+1,fxSmokeLarge)
{
	direction = random_range(0,360)
	speed = random_range(1,3)
}