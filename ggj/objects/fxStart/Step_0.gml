if (global.key_interact) or (global.active_player_object.state != pStates.ghost)
{
	instance_create_depth(x,y,0,fxMiddle);
	instance_destroy();
}

if (image_index > 2)
{
	image_speed = 0;
	image_index = 2;
}