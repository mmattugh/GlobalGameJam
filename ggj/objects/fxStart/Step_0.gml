if (global.key_interact) or (oCharacter.state = pStates.follow_trail)
{
	instance_create_depth(x,y,0,fxMiddle);
	instance_destroy(self);
}

if (animation_end())
{
	image_speed = 0;
	image_index = 2;
}