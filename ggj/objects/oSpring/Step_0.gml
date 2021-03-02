/// @description 
switch state {
	case "down":
	image_speed = 0;
	image_index = 0;
	
	var inst = instance_place(x,y,global.active_player_object.object_index);
	if (inst == noone or inst.state != pStates.move) {
		inst = instance_place(x,y,oBonkBlock);	
	}
	if (inst) {
		if !(inst.sprung_this_frame) {
			var new_vsp, new_hsp, new_xscale, new_yscale;
			var ang = round((image_angle+global.down_direction-270+360) mod 360);
			switch ang {
				case 90:
				new_vsp = min(0, inst.vsp);
				new_hsp = -other.spring_accel_h;
				new_xscale = 1.5;
				new_yscale = 0.5;
				break;
				case 180:
				new_vsp = other.spring_accel_v;
				new_hsp = inst.hsp;
				new_xscale = 0.5;
				new_yscale = 1.5;
				break;
				case 270:
				new_vsp = min(0, inst.vsp);
				new_hsp = other.spring_accel_h;
				new_xscale = 1.5;
				new_yscale = 0.5;
				break;
				case 0:
				new_vsp = -other.spring_accel_v;
				new_hsp = inst.hsp;
				new_xscale = 0.5;
				new_yscale = 1.5;
				break;
			}
			
			//show_debug_message(string(new_hsp) + " " + string(new_vsp));
			
			oCamera.screenshake += 4;
			with inst {
				sprung_this_frame = true;
				vsp = new_vsp;
				hsp = new_hsp;
				draw_xscale = new_xscale;
				draw_yscale = new_yscale;
			
			
				if object_index == global.active_player_object.object_index and !(has_ghost) {
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