
if place_meeting(x,y,oCharacter) {
	// TODO: get soul sfx
	
	instance_destroy();
	with instance_create_depth(x,y,depth,oWisp) {
		direction = 90;	
	}
	instance_create_depth(x,y,depth,fxSoulAfterImage);
}