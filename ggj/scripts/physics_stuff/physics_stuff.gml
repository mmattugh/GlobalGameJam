// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function move_with_physics() {
//rotate physcis box

#region move object

var xsp;
var ysp;
switch global.down_direction {
	case 0:
	xsp = -vsp;
	ysp =  hsp;
	break;
	case 90:
	xsp = -hsp;
	ysp = -vsp;
	break
	case 180:
	xsp =  vsp;
	ysp = -hsp;
	break;
	case 270:
	xsp =  hsp;
	ysp =  vsp;
	break;
}


if !place_meeting(x+xsp, y+ysp, Solid) {
	x += xsp;
	y += ysp;
} else {
	var temp_hsp = floor(xsp);
	var temp_vsp = floor(ysp);

	var sign_hsp = sign(xsp);
	var sign_vsp = sign(ysp);
	
	var frac_hsp = frac(xsp);
	var frac_vsp = frac(ysp);
	while (abs(temp_hsp) > 0 && abs(temp_vsp) > 0) {
		if !(place_meeting(x+sign_hsp, y+sign_vsp, Solid)) {
			x += sign_hsp;
			y += sign_vsp;				  
			temp_hsp = approach(temp_hsp, 0, 1);
			temp_vsp = approach(temp_vsp, 0, 1);
		} else {
			if place_meeting(x + sign_hsp, y, Solid) {
				temp_hsp = 0;	
				#region
				switch global.down_direction {
					case 0:
					vsp = 0;
					break;
					case 90:
					hsp = 0;
					break
					case 180:
					vsp = 0;
					break;
					case 270:
					hsp = 0;
					break;
				}
				#endregion
			}
			if place_meeting(x, y + sign_vsp, Solid) {
				temp_vsp = 0;
				#region
				switch global.down_direction {
					case 0:
					hsp = 0;
					break;
					case 90:
					vsp = 0;
					break
					case 180:
					hsp = 0;
					break;
					case 270:
					vsp = 0;
					break;
				}
				#endregion
			}
			break;
		}
	}
	
	for (var i = 0; i < abs(temp_hsp); i++) {
		if !place_meeting(x + sign_hsp, y, Solid) {
			x += sign_hsp;
		} else {
			temp_hsp = 0;
			#region
			switch global.down_direction {
				case 0:
				vsp = 0;
				break;
				case 90:
				hsp = 0;
				break
				case 180:
				vsp = 0;
				break;
				case 270:
				hsp = 0;
				break;
			}
			#endregion
			break;
		}
	}
	
	for (var i = 0; i < abs(temp_vsp); i++) {
		if !place_meeting(x, y + sign_vsp, Solid) {
			y += sign_vsp;
		} else {
			temp_vsp = 0;
			#region
			switch global.down_direction {
				case 0:
				hsp = 0;
				break;
				case 90:
				vsp = 0;
				break
				case 180:
				hsp = 0;
				break;
				case 270:
				vsp = 0;
				break;
			}
			#endregion
			break;
		}
	}
	
	//if place_meeting(x+dcos(global.down_direction), y, Solid) {
	//	hsp = 0;	
	//}
	
	//if place_meeting(x, y+dsin(global.down_direction), Solid) {
	//	vsp = 0;	
	//}

	if !place_meeting(x + frac_hsp, y, Solid) {
		x += frac_hsp;
	}
	
	if !place_meeting(x, y + frac_vsp, Solid) {
		y += frac_vsp;
	}
	if (place_meeting(x,y,Solid)) {
		//show_debug_message("big problem baby");
		//var height = sprite_get_height(mask_index);
		//var width = sprite_get_width(mask_index);
		//var h = height;
		//var v = width;
		//var xsp, ysp;
		//switch global.down_direction {
		//	case 0:
		//	xsp = -v;
		//	ysp =  h;
		//	break;
		//	case 90:
		//	xsp = -h;
		//	ysp = -v;
		//	break
		//	case 180:
		//	xsp =  v;
		//	ysp = -h;
		//	break;
		//	case 270:
		//	xsp =  h;
		//	ysp =  v;
		//	break;
		//}
		
		//for (var i = 0; i < 360; i+=90) {
		//	if (!place_meeting(x+dcos(i)*xsp,y+dsin(i)*ysp,Solid)) {
		//		x += dcos(i)*xsp; y += dsin(i)*ysp;
		//	}
		//}
	}
	
}

#endregion
}

function rotated_place_meeting(x,y,xoff,yoff,object) {
	var prev = image_angle;
	image_angle = 270-global.down_direction;
	switch global.down_direction {
		case 0:
		return place_meeting(x-yoff,y+xoff,object);
		break;
		case 90:
		return place_meeting(x-xoff,y-yoff,object);
		break
		case 180:
		return place_meeting(x+yoff,y-xoff,object);
		break;
		case 270:
		return place_meeting(x+xoff,y+yoff,object);
		break;
	}
	image_angle = prev;
}

function rotated_instance_create(x,y,xoff,yoff,depth,object) {
	var ret;
	switch global.down_direction {
		case 0:
		ret = instance_create_depth(x-yoff, y+xoff, depth, object);
		break;
		case 90:
		ret = instance_create_depth(x-xoff,y-yoff, depth, object);
		break
		case 180:
		ret = instance_create_depth(x+yoff,y-xoff, depth, object);
		break;
		case 270:
		ret = instance_create_depth(x+xoff,y+yoff, depth, object);
		break;
	}
	
	ret.image_angle = 270-global.down_direction;
	return ret;
}

// function to fix hitboxes being stuck in corners after rotating
// designed around bottom centered sprites
function obj_unfuck(diff) {
	if (!rotated_place_meeting(x,y,0,0,Solid)) exit;
	var height = sprite_get_height(mask_index);
	var width = sprite_get_width(mask_index);

	var v = 0;
	var h = 0;
	if (abs(diff) == 90) {
		h = -height/2 * sign(diff);
		if (rotated_place_meeting(x,y,0,-1,Solid)) {
			v = width/2
		}  
		if (rotated_place_meeting(x,y,h,v,Solid)) {
			v = -width/2
		}
	} else if (abs(diff) == 180) {
		v = height;
		h = 0;
		
		if (rotated_place_meeting(x,y,1,v,Solid)) {
			//h = -2
		} 
		//if (rotated_place_meeting(x,y,-1,v,Solid)) {
		//	h = 2
		//} 
	}
	
	var xsp, ysp;
	switch global.down_direction {
		case 0:
		xsp = -v;
		ysp =  h;
		break;
		case 90:
		xsp = -h;
		ysp = -v;
		break
		case 180:
		xsp =  v;
		ysp = -h;
		break;
		case 270:
		xsp =  h;
		ysp =  v;
		break;
	}
	
	x += xsp;
	y += ysp;
	
	

	if (place_meeting(x,y,Solid)) {
		
		v = height;
		h = width;
		var xsp, ysp;
		switch global.down_direction {
			case 0:
			xsp = -v;
			ysp =  h;
			break;
			case 90:
			xsp = -h;
			ysp = -v;
			break
			case 180:
			xsp =  v;
			ysp = -h;
			break;
			case 270:
			xsp =  h;
			ysp =  v;
			break;
		}
		
		for (var i = 0; i < 360; i+=90) {
			if (!place_meeting(x+dcos(i)*xsp,y+dsin(i)*ysp,Solid)) {
				x += dcos(i)*xsp; y += dsin(i)*ysp;
			}
		}
		
		return
	}
	
	show_debug_message("big problem baby");
}