/// @description 

switch state {
	case "down":
	mask_index = sPopUpSpikes;
	if (place_meeting(x,y,oCharacter)) {
		state = "trans";
	}
	
	mask_index = sNothing;
	break;
	case "trans":
	image_index = (image_number)*pop_up/pop_up_delay;
	pop_up++;
	
	if (pop_up >= pop_up_delay) {
		state = "up";	
	}
	
	break;
	case "up":
	mask_index = sprite_index;
	
	break;
}