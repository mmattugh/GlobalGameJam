
if (global.active_player_object.state != pStates.move) or 
   (abs(global.active_player_object.vsp) > global.active_player_object.jump_accel) or
   (abs(global.active_player_object.hsp) > global.active_player_object.move_speed) or 
   (global.key_down) {
	hitbox.mask_index = sNothing;	
} else {
	hitbox.mask_index = sWall;	
}

if (place_meeting(x,y,global.active_player_object)) {
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
	
	play_sound(choose(Block_Break_01, Block_Break_02, Block_Break_03), 40, false, 1.0, 0.02, global.sound_volume);
	
	instance_destroy(hitbox);
	instance_destroy();
}