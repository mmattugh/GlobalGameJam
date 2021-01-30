/// @description 

//if (oCharacter.state != pStates.follow_trail) {
//    image_xscale = lerp(image_xscale, 1.0, scale_snap_speed);
//    image_yscale = lerp(image_yscale, 1.0, scale_snap_speed);
//} else {
    var dist = point_distance(x,y,oCharacter.x,oCharacter.y);
    var scale = min(1, dist/trail_fade_distance);
    image_xscale = lerp(image_xscale, scale, scale_snap_speed);
    image_yscale = lerp(image_yscale, scale, scale_snap_speed);
//}

if (forgiveness > 0) {
    forgiveness--;    
    
    if (forgiveness <= 0) {
        mask_index = sprite_index;    
		
    }
}

if (place_meeting(x,y,oLaser)) {
	//destroy_self();		
			
	if (audio_is_playing(oGhost.trail_sound_id)) {
		audio_stop_sound(oGhost.trail_sound_id);	
	}
			
	// TODO: zapped sfx			
	oCharacter.state = pStates.death;
	exit;
}