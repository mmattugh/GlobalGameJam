//draw_text(20,20,string(fall_time))
if (instance_exists(oGhost)) {
	//draw_text(20,40,string(oGhost.trail_length_max - oGhost.trail_length))
}



draw_sprite_ext(sprite_index,image_index,x,y,draw_xscale*flipped,draw_yscale,draw_angle,c_white,image_alpha);

//draw_sprite_ext(sCharacter_Ammo,has_ghost,x,y-6,draw_xscale*flipped,draw_yscale,draw_angle,c_white,image_alpha);

/*
if (has_ghost)
{

}
else
{
	draw_sprite_ext(sprite_index,image_index,x,y,draw_xscale*flipped,draw_yscale,draw_angle,c_red,image_alpha)
}



