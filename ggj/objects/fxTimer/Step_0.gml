/// @description Insert description here
// You can write your code in this editor
image_xscale = lerp(image_xscale, 1.0, 0.35);
image_yscale = lerp(image_yscale, 1.0, 0.35);

target_offset = lerp(target_offset, target_target_offset, 0.25);

switch global.down_direction {
	case 270:
	y = lerp(y, ystart - target_offset, 0.35);
	break;
	case 0:
	x = lerp(x, xstart + target_offset, 0.35);
	break;
	case 90:
	y = lerp(y, ystart + target_offset, 0.35);
	break;
	case 180:
	x = lerp(x, xstart - target_offset, 0.35);
	break;		
}

if (white_time > 0) {
	white_time--;
	
	if (white_time) {
		rotated_instance_create(x,y,0,0,depth+1,fxSmoke);	
	}
}

life_time--;
if (life_time <= 0) instance_destroy();