
if place_meeting(x,y,oCharacter) {
	play_sound(Soul_Shatter, 50, false, 1.0, 0.02, global.sound_volume);
	
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