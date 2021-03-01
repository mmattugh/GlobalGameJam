//y = ystart + 2*dsin(current_time*0.2);
y = lerp(y, ystart + 2*dsin(current_time*0.2)*dsin(global.down_direction), 0.5);
x = lerp(x, xstart + 2*dsin(current_time*0.2)*dcos(global.down_direction), 0.5);

// special case for endless mode
if (ystart != target_ystart) {
	ystart = lerp(ystart, target_ystart, 0.2);	
	
	if (abs(y-ystart) > 2)
		rotated_instance_create(x,y,random_range(-8, 8), 0, depth-1, fxSmoke);
}

switch (state)
{
	case recharge.enabled:
	{
		
		smoke_FX++;
		if (smoke_FX > 10)with (rotated_instance_create(x,y,random_range(-5,5),-8,other.depth+1,fxSmokeLarge))
		{
			other.smoke_FX = 0;
			speed = random_range(0.5,1)
			direction = 90+270-global.down_direction;
		}
		
		depth = 0;
		sprite_index = sRecharge
		mask_index = sRecharge
		if (place_meeting(x,y,oCharacter))
		{
			oCharacter.has_ghost = true;
			//instance_create_depth(oCharacter.x,oCharacter.y,oCharacter.depth-2,fxRecharged);
			rotated_instance_create(oCharacter.x,oCharacter.y,0,0,oCharacter.depth-2,fxRecharged);
			//oCharacter.hsp = 0;
			//oCharacter.vsp = 0;
			play_sound(Ghost_Recharge, 40, false, 1.0, 0.05, global.sound_volume*0.5);
			play_sound(Snap, 10, false, 1.0, 0.01, global.sound_volume);

			
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
		
		if (id.health_ > regen_time-15) {
			if (floor(id.health_/3) mod 2 == 1) {
				sprite_index = sRecharge_Hit;
			}
		}
		
		if (id.health_ > regen_time)
		{
			state = recharge.regen;
		}

	}break;
	case recharge.regen:
		sprite_index = sRecharge_Hit;
		id.health_ = 0;
		if (ceil(image_index) == 2) state = recharge.enabled;
	break;
}