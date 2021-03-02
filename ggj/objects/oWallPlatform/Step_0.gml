/// @description Insert description here
// You can write your code in this edito

if (instance_exists(global.active_player_object))
{
	if (round(global.active_player_object.y) > y) or (global.key_down)
	{
		mask_index = sNothing;
		
		if (global.key_down) {
			reset = 5;
		}
	}
	else {
		if (reset == 0) {	
			mask_index = sPlatform 
		} else {
			reset--;	
		}
	}
}