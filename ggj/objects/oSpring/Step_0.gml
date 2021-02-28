/// @description 


switch state {
	case "down":
	image_speed = 0;
	image_index = 0;
	
	if (place_meeting(x,y,oCharacter) and oCharacter.state == pStates.move) {
		if !(oCharacter.sprung_this_frame) {
			var new_vsp, new_hsp, new_xscale, new_yscale;
			switch image_angle {
				case 90:
				new_vsp = min(0, oCharacter.vsp);
				new_hsp = -other.spring_accel_h;
				new_xscale = 1.5;
				new_yscale = 0.5;
				break;
				case 180:
				new_vsp = other.spring_accel_v;
				new_hsp = oCharacter.hsp;
				new_xscale = 0.5;
				new_yscale = 1.5;
				break;
				case 270:
				new_vsp = min(0, oCharacter.vsp);
				new_hsp = other.spring_accel_h;
				new_xscale = 1.5;
				new_yscale = 0.5;
				break;
				default: case 0:
				new_vsp = -other.spring_accel_v;
				new_hsp = oCharacter.hsp;
				new_xscale = 0.5;
				new_yscale = 1.5;
				break;
			}
			
			oCamera.screenshake += 4;
			with oCharacter {
				sprung_this_frame = true;
				vsp = new_vsp;
				hsp = new_hsp;
				draw_xscale = new_xscale;
				draw_yscale = new_yscale;
			
				if !(has_ghost) {
					set_has_ghost();
						
				}
			}
		}
		state = "push";
	}
	
	break;
	case "push":
	image_speed = 1;
	
	if (image_index >= push_frame+1) {
		state = "up";
		image_index = reset_frame_start;
	}	
	
	break;
	case "up":
	image_speed = 0;
	image_index += reset_frames/reset_time;
	
	if (image_index >= image_number-1) {
		state = "down";	
	}
	
	break;
}