/// @description 
hsp = 0;
vsp = 0;
hfriction = 0.3;
vfriction = 0.3;

bonk_impulse = 6;
lock_directions = true;


attached_spikes_count = 0;
attached_spikes = ds_list_create();

// build list
check_for_attached_spike = function(x,y) {
	var inst = instance_place(x,y,pHazard);
	if (inst) {
		attached_spikes_count++;
		ds_list_add(attached_spikes, inst);
		instance_deactivate_object(inst);
	}
}

mask_index = sWall;
// top two
check_for_attached_spike(x,y-16);
check_for_attached_spike(x+sprite_width-16,y-16);

// left two
check_for_attached_spike(x-16,y);
check_for_attached_spike(x-16,y+sprite_height-16);

// right two
check_for_attached_spike(x+sprite_width/2+16,y);
check_for_attached_spike(x+sprite_width/2+16,y+sprite_height-16);

// bottom two
check_for_attached_spike(x,y+sprite_height/2+16);
check_for_attached_spike(x+sprite_width-16,y+sprite_height/2+16);

mask_index = sprite_index;
instance_activate_object(pHazard);