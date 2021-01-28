/// @description Insert description here
// You can write your code in this editor
draw_text(20,20,state)


if (ammo)
{
draw_sprite_ext(sprite_index,image_index,x,y,xscale_*flipped,yscale_,0,c_green,image_alpha);
}
else
{
	draw_sprite_ext(sprite_index,image_index,x,y,xscale_*flipped,yscale_,0,c_red,image_alpha)
}



