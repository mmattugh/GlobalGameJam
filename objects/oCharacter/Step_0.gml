//Check to see if object is grounded
grounded = (place_meeting(x,y+1,Solid));

switch (state)
{
	case pState.move:
	{
		if (global.key_interact) && (ammo)
		{
			ammo--;
				with instance_create_depth(x,y-32,depth,oSoul) 
				{
					image_angle = 90;
					global.key_interact = false;
				}
				state = pState.spirit;

		}


			//Movement
				var move = global.key_right - global.key_left;
				
				hsp = move * walkSpeed + hspboost;
				vsp = vsp + grvSpeed;
		
				var hsp_final = hsp + hsp_carry;		
				//Collision
				if(place_meeting(x+hsp_final,y,Solid))
				{
					while (!place_meeting(x+sign(hsp_final),y,Solid))
					{
						x += sign(hsp_final); 
					}
					hsp_final = 0;
					hspboost = 0;
					vspboost = 0;
				}
				x = x + hsp_final;
	
				if(place_meeting(x, y+vsp, Solid))
				{
					while(!place_meeting(x,y+sign(vsp),Solid))
					{
						y += sign(vsp); 
					}
					vsp = 0;
					vspboost = 0;
					hspboost = 0;
			
				}
				y = y + vsp;
			//	
	

		
			//if possessed object can jump
			if (global.key_jump) && (grounded)
			{
				//Jump FX
				instance_create_depth(x,y,depth+1,fxJump);
				//
				vsp = vsp - jumpHeight;
				xscale_ = 0.7;
				yscale_ = 1.3;
			}
			//

			//Animation
				if (!grounded) //Animation in the air
				{
					image_speed = 0;
		
					sprite_index = sCharacter_Air;
		
					if (vsp > 0.2) image_index = 2;
					else if (vsp < -0.2) image_index = 0;
					else image_index = 1;
				}
				else //Animations on the ground
				{
					//Land Anim
					if (sprite_index = sCharacter_Air)
					{
						ammo = 1;
						instance_create_depth(x,y,depth+1,fxLand);			
						xscale_ = 1.3;
						yscale_ = 0.7;
					}
		
					image_speed = 1;
					if (hsp != 0) 
					{
						sprite_index = sCharacter_Walk;
					}
					else 
					{
						sprite_index = sCharacter_Idle;
					}
				}
		
		
			if (hsp != 0) flipped = sign(hsp);

	}break;
	case pState.spirit:
	{
		if (global.key_interact)
		{
			state = pState.prelaunch;
	
			global.key_interact = false;
		}

				hsp = 0;
				vsp = 0;
		
				var hsp_final = hsp + hsp_carry;		
				//Collision
				if(place_meeting(x+hsp_final,y,Solid))
				{
					while (!place_meeting(x+sign(hsp_final),y,Solid))
					{
						x += sign(hsp_final); 
					}
					hsp_final = 0;
				}
				x = x + hsp_final;
	
				if(place_meeting(x, y+vsp, Solid))
				{
					while(!place_meeting(x,y+sign(vsp),Solid))
					{
						y += sign(vsp); 
					}
					vsp = 0;
			
				}
				y = y + vsp;
			//	
	
			//

			//Animation
				if (!grounded) //Animation in the air
				{
					image_speed = 0;
		
					sprite_index = sCharacter_Air;
		
					if (vsp > 0.2) image_index = 2;
					else if (vsp < -0.2) image_index = 0;
					else image_index = 1;
				}
				else //Animations on the ground
				{
					//Land Anim
					if (sprite_index = sCharacter_Air)
					{
						instance_create_depth(x,y,depth+1,fxLand);			
						xscale_ = 1.3;
						yscale_ = 0.7;
					}
		
					image_speed = 1;
					if (hsp != 0) 
					{
						sprite_index = sCharacter_Walk;
					}
					else 
					{
						sprite_index = sCharacter_Idle;
					}
				}
		
		

	}break;
	case pState.prelaunch:
	{
		oSoul.spd = 0;
		
		if (place_meeting(x,y,oSoul))
		{
			hsp = 0;
			vsp = 0;
			x = oSoul.x;
			y = oSoul.y;

			state = pState.launch;
		}
		
		if (instance_exists(oSoulPath)) 
		{
			mytarget = instance_nearest(x,y,oSoulPath);//find closest enemy
			direction = point_direction(x, y, mytarget.x, mytarget.y)
		}
		speed = 5
		
	}break;
	case pState.launch:
	{
		speed = 0;
		
		oSoul.spd = 0;
		
		hspboost = hspboost + lengthdir_x(6,oSoul.image_angle)
		vsp = vsp + lengthdir_y(6,oSoul.image_angle)
				
		x = x + hspboost;
		y = y + vsp;
		
		if (place_meeting(x,y,oSoul))
		{
			instance_destroy(oSoul);
			instance_destroy(oSoulPath);
			state = pState.move;
			global.key_interact = false;

		}


		
	}break;
//if canPassThrough

//if canDie has health

// Squash and strech stuff

}
if (hsp != 0) flipped = sign(hsp);
xscale_ = lerp(xscale_,image_xscale,.2)
yscale_ = lerp(yscale_,image_yscale,.2)