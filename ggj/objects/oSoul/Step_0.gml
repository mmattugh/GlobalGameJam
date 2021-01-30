
if place_meeting(x,y,oCharacter) {
	// TODO: get soul sfx
	
	scr_freeze(60)
	oCamera.screenshake += 2;
	
	instance_destroy();
	with instance_create_depth(x,y,depth,oWisp) {

		direction = 90;	
	}
	with instance_create_depth(x,y,depth,fxSoulAfterImage)
	{
		image_xscale = other.image_xscale
		image_angle = other.image_angle
	}
}