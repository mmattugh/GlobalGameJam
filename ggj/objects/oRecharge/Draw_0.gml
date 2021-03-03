var xoff = 0, yoff = 0, draw_angle;
switch (180-global.down_direction+360) mod 360 {
	case 270:
	draw_angle = 0;
	break;
	case 0:
	draw_angle = 90;
	break;
	case 90:
	draw_angle = 180;
	break;
	case 180:
	draw_angle = 270;
	break;
}

draw_sprite_ext(sprite_index,image_index,x+xoff,y+yoff+2*dsin(current_time*0.2),image_xscale,image_yscale,draw_angle,c_white,image_alpha)
