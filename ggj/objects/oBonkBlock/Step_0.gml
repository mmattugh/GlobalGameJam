/// @description 

hsp = approach(hsp, 0, hfriction);
vsp = approach(vsp, 0, vfriction);

if (hsp != 0 or vsp != 0) {
	// make particles
	for (var i = 0; i < sprite_width; i+=sprite_width/4) {
		for (var j = 0; j < sprite_height; j+=sprite_height/4) {
			var s = (abs(hsp) + abs(vsp))
			if (chance(1.5*s)) {
				var inst = instance_create_depth(x+i,y+j,depth,fxSmokeLarge);	
				inst.image_speed = s/4;
			}	
			if (chance(s)) {
				var inst = instance_create_depth(x+i,y+j,depth,fxSmoke);
				inst.image_speed = s/4;
			}
		}
	}
	
	// move
	var prev_x = x;
	var prev_y = y;
	move_with_physics();
	
	if attached_spikes_count > 0 {
		var diff_x = x-prev_x;
		var diff_y = y-prev_y;
		var inst;
		for (var i = 0; i < attached_spikes_count; i++) {
			inst = ds_list_find_value(attached_spikes, i);
			inst.x += diff_x;
			inst.y += diff_y;
		}
	}
}

