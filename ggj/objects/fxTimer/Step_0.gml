/// @description Insert description here
// You can write your code in this editor
image_xscale = lerp(image_xscale, target_image_xscale, 0.35);
image_yscale = lerp(image_yscale, target_image_yscale, 0.35);

target_offset = lerp(target_offset, target_target_offset, 0.25);

target_image_xscale = lerp(target_image_xscale, target_target_image_xscale, 0.25);
target_image_yscale = lerp(target_image_yscale, target_target_image_yscale, 0.25);

switch global.down_direction {
	case 270:
	y = lerp(y, global.active_player_object.y - target_offset, 0.35);
	x = global.active_player_object.x;
	break;
	case 0:
	y = global.active_player_object.y;
	x = lerp(x, global.active_player_object.x + target_offset, 0.35);
	break;
	case 90:
	y = lerp(y, global.active_player_object.y + target_offset, 0.35);
	x = global.active_player_object.x;
	break;
	case 180:
	y = global.active_player_object.y;
	x = lerp(x, global.active_player_object.x - target_offset, 0.35);
	break;		
}

if (white_time > 0) {
	white_time--;
	
	if (white_time > 2) {
		rotated_instance_create(x,y,0,0,depth+1,fxSmoke);	
	}
}

life_time--;
if (life_time <= 0) instance_destroy();