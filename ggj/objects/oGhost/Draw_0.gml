/// @description 
draw_sprite_ext(sprite_index, image_index, x, y, draw_xscale, draw_yscale, move_direction, image_blend, image_alpha);

// draw arrows

if (arrows_enabled) {
	var img = (turn_direction < 0);
	right_arrow_scale = lerp(right_arrow_scale, 1.0 + 0.5*img + 0.1*dsin(current_time*0.2), 0.2);

	draw_sprite_ext(sGhostArrow, img, x, y, right_arrow_scale, right_arrow_scale, move_direction-90, image_blend, image_alpha);

	var img = (turn_direction > 0);
	left_arrow_scale = lerp(left_arrow_scale, 1.0 + 0.5*img + 0.1*dsin(current_time*0.2), 0.2);

	draw_sprite_ext(sGhostArrow, img, x, y, -left_arrow_scale, left_arrow_scale, move_direction-90, image_blend, image_alpha);
}