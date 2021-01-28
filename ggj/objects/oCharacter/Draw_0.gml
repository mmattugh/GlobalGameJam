draw_text(20,20,string(vsp))
draw_text(20,40,string(on_ground))



if (has_ghost)
{
draw_sprite_ext(sprite_index,image_index,x,y,draw_xscale*flipped,draw_yscale,draw_angle,c_green,image_alpha);
}
else
{
	draw_sprite_ext(sprite_index,image_index,x,y,draw_xscale*flipped,draw_yscale,draw_angle,c_red,image_alpha)
}



