/// @description 

//if (oCharacter.state != pStates.follow_trail) {
//    image_xscale = lerp(image_xscale, 1.0, scale_snap_speed);
//    image_yscale = lerp(image_yscale, 1.0, scale_snap_speed);
//} else {
    var dist = point_distance(x,y,global.active_player_object.x,global.active_player_object.y);
    var scale = min(1, dist/trail_fade_distance);
    image_xscale = lerp(image_xscale, image_scale*scale, scale_snap_speed);
    image_yscale = lerp(image_yscale, image_scale*scale, scale_snap_speed);
//}

if (forgiveness > 0) {
    forgiveness--;    
    
    if (forgiveness <= 0) {
        mask_index = sprite_index;    
		
    }
}


var temp_mask_index = mask_index;
mask_index = sPlayerHitbox;
var inst = instance_place(x,y,oLaser);
if (inst and inst.active) {
	//destroy_self();		
			
	if (audio_is_playing(oGhost.trail_sound_id)) {
		audio_stop_sound(oGhost.trail_sound_id);	
	}
			
	creator_player_object.state = pStates.death;
	play_sound(Self_Zapped_by_Laser, 50, false, 1.0, 0.02, global.sound_volume);
	exit;
}
mask_index = temp_mask_index;