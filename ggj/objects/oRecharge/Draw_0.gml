var xoff = 0, yoff = 1, draw_angle;
switch (180-global.down_direction+360) mod 360 {
	case 270:
	draw_angle = 0;
	break;
	case 0:
	draw_angle = 90;
	xoff = 1;
	yoff = 0;
	break;
	case 90:
	draw_angle = 180;
	break;
	case 180:
	draw_angle = 270;
	xoff = 1;
	yoff = 0;
	break;
}
var c = 2*dsin(current_time*0.2)

draw_sprite_ext(sprite_index,image_index,x+xoff*c,y+yoff*c,image_xscale,image_yscale,draw_angle,c_white,image_alpha)


if state == recharge.disabled {
	gpu_set_colorwriteenable([true,true,true,false]);
	gpu_set_blendmode(bm_max);
	draw_pie( x+xoff*c,y+yoff*c, health_, regen_time, c_dkgray, 16);
	gpu_set_blendmode(bm_normal);
	gpu_set_colorwriteenable([true,true,true,true]);

}