// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function move_with_physics() {
#region move object

if !place_meeting(x+hsp, y+vsp, Solid) {
	x += hsp;
	y += vsp;
} else {
	var temp_hsp = floor(hsp);
	var temp_vsp = floor(vsp);

	var sign_hsp = sign(hsp);
	var sign_vsp = sign(vsp);
	
	var frac_hsp = frac(hsp);
	var frac_vsp = frac(vsp);
	while (abs(temp_hsp) > 0 && abs(temp_vsp) > 0) {
		if !(place_meeting(x+sign_hsp, y+sign_vsp, Solid)) {
			x += sign_hsp;
			y += sign_vsp;				  
			temp_hsp = approach(temp_hsp, 0, 1);
			temp_vsp = approach(temp_vsp, 0, 1);
		} else {
			if place_meeting(x + sign_hsp, y, Solid) {
				temp_hsp = 0;	
				hsp = 0;
			}
			if place_meeting(x, y + sign_vsp, Solid) {
				temp_vsp = 0;
				vsp = 0;
			}
			break;
		}
	}
	
	for (var i = 0; i < abs(temp_hsp); i++) {
		if !place_meeting(x + sign_hsp, y, Solid) {
			x += sign_hsp;
		} else {
			temp_hsp = 0;
			hsp = 0;
			break;
		}
	}
	
	for (var i = 0; i < abs(temp_vsp); i++) {
		if !place_meeting(x, y + sign_vsp, Solid) {
			y += sign_vsp;
		} else {
			temp_vsp = 0;
			vsp = 0;
			break;
		}
	}

	if !place_meeting(x + frac_hsp, y, Solid) {
		x += frac_hsp;
	}
	
	if !place_meeting(x, y + frac_vsp, Solid) {
		y += frac_vsp;
	}
}

#endregion
}