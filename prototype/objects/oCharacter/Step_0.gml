//Check to see if object is grounded
grounded = (place_meeting(x,y+vsp+1,Solid));

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
			
			//if (!place_meeting(oSoul.x, oSoul.y, oWall)) {
			//	x = oSoul.x;
			//	y = oSoul.y;
			//}

			state = pState.launch;
		}
		
		if (instance_exists(oSoulPath)) 
		{
			try {
				instance_destroy(mytarget);
			} catch (ex) {
				// dont care	
				show_debug_message(ex);
			}
			if !(mytarget == noone or !instance_exists(mytarget)) and (instance_exists(mytarget.next)) {
				mytarget = mytarget.next;
			} else {
				mytarget = instance_nearest(x, y,oSoulPath);//find closest path
			}
			direction = point_direction(x, y, mytarget.x, mytarget.y)
		}

		var x_step = lengthdir_x(1, direction); 
		var y_step = lengthdir_y(1, direction);
		for (var i = 0; i < 4; i++) {
			if (!place_meeting(x+x_step, y+y_step, oWall)) {
				x += x_step;
				y += y_step;
				
				var inst = instance_place(x,y,oSoulPath);
				if (inst != noone and inst != mytarget) {
					instance_destroy(inst);	
				}
			}
		}
		
	}break;
	case pState.launch:
	{
		speed = 0;
		
		oSoul.spd = 0;
		
		hspboost = hspboost + lengthdir_x(3,oSoul.image_angle)
		vsp = vsp + lengthdir_y(4,oSoul.image_angle)
				
				
		if !place_meeting(x,y,oWall) {
			x = x + hspboost;
			y = y + vsp;
		} else {
			var abs_hspboost = abs(hspboost);
			var sign_hspboost = sign(hspboost);
			for (var i = 0; i < abs_hspboost; i++) {	
				var xxx = sign_hspboost*min(abs_hspboost, 1)
				if !place_meeting(x+xxx,y,oWall) {
					x += xxx;
					sign_hspboost -= abs(xxx);
				}
			}
			
			var abs_vsp = abs(vsp);
			var sign_vsp = sign(vsp);
			for (var i = 0; i < abs_vsp; i++) {	
				var yyy = sign_vsp*min(abs_vsp, 1)
				if !place_meeting(x,y+yyy,oWall) {
					x += yyy;
					sign_vsp -= abs(yyy);
				}
			}
		}
		
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