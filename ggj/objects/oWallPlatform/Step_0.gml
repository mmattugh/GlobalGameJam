/// @description Insert description here
// You can write your code in this editor
if (instance_exists(oCharacter))
{
	if (round(oCharacter.y) > y) or (global.key_down)
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