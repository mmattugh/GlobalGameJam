y = ystart + 2*dsin(current_time*0.2);

switch (state)
{
	case recharge.enabled:
	{
		
		smoke_FX++;
		if (smoke_FX > 10)with (instance_create_depth(random_range(x-5,x+5),y-8,other.depth+1,fxSmokeLarge))
		{
			other.smoke_FX = 0;
			speed = random_range(0.5,1)
			direction = 90;
		}
		
		depth = 0;
		sprite_index = sRecharge
		mask_index = sRecharge
		if (place_meeting(x,y,oCharacter))
		{
			oCharacter.has_ghost = true;
			//oCharacter.hsp = 0;
			//oCharacter.vsp = 0;
			// TODO: ghost recharge sfx
			
			scr_freeze(240)
			mask_index = sNothing;
			image_index = 0;
			state = recharge.hit;
		}
	}break;
	case recharge.hit:
	{
		sprite_index = sRecharge_Hit;
		id.health_ = 0;
		if (ceil(image_index) == 2) state = recharge.disabled;
	}break;
	case recharge.disabled:
	{
		depth = 100;
		sprite_index = sRecharge_Recharge;
		id.health_ ++;
		if (id.health_ > 320)
		{
			state = recharge.enabled;
		}

	}break;
}