instance_create_depth(x,y,0,oSoulPath)

if (place_meeting(x,y,oWall))
{
	oCharacter.state = pState.move;
	instance_destroy(oSoulPath);
	instance_destroy(self);
}
if (place_meeting(x,y,oSoulPath)) && (spd != 0)
{
	oCharacter.state = pState.move;
	instance_destroy(oSoulPath);
	instance_destroy(self);
}


if (place_meeting(x,y,oCharacter)) && (spd != 0)
{
	oCharacter.state = pState.move;
	instance_destroy(oSoulPath);
	instance_destroy(self);
}
image_index = image_angle * 0.1 - 9;
 
	
	dir = image_angle;
	
	if (place_meeting(x,y,oWall))
	{
		image_alpha = image_alpha - 0.02;
	}
	else image_alpha = image_alpha - 0.001;
	
	x = x + lengthdir_x(spd,dir);

	y = y + lengthdir_y(spd,dir);


	if (global.key_right)
	{
	image_angle = image_angle - turnspd;		
	}
	else if (global.key_left)
	{
		image_angle = image_angle + turnspd;
	}