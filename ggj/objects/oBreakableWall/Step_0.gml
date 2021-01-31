
if (oCharacter.state != pStates.move) or 
   (abs(oCharacter.vsp) > oCharacter.jump_accel) or
   (abs(oCharacter.hsp) > oCharacter.move_speed) {
	hitbox.mask_index = sNothing;	
} else {
	hitbox.mask_index = sWall;	
}

if (place_meeting(x,y,oCharacter)) {
	// create particles
	for (var i = 0; i < 4; ++i) {
		with instance_create_depth(x,y,depth-1, fxBreakableWallParticle) {
			image_angle = i * 90;
			direction = 135 + image_angle;
			speed = 4;
		}
	}
	
	instance_create_depth(x,y,depth-3, fxBreakableWallAfterImage);

	
	// do camera
	oCamera.screenshake += 3;
	scr_freeze(10)
	
	// TODO: block break sfx
	
	instance_destroy(hitbox);
	instance_destroy();
}