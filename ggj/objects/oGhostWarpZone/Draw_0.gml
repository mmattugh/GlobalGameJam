/// @description 
try {
//shader_set(shdJelly);
//shader_set_uniform_f(oCamera.jelly_time, current_time*0.003);

//var arr = [hit_point_x, hit_point_y, hit_magnitude]
//shader_set_uniform_f_array(oCamera.jelly_point, arr);

//vertex_submit(vertex_buffer, pr_trianglelist, texture);

//shader_reset();
} catch (err) {
	
} finally {
	//draw_self();
	for (var i = 0; i < sprite_width/16; i++) {
	for (var j = 0; j < sprite_height/16; j++) {
		draw_sprite(sprite_index, image_index, x+i*16, y+j*16);
	}
	}
	
	draw_sprite(sCorner, 0, x, y);
	draw_sprite(sCorner, 1, x + sprite_width-16, y);
	draw_sprite(sCorner, 2, x + sprite_width-16, y + sprite_height-16);
	draw_sprite(sCorner, 3, x, y + sprite_height-16);


	for (var i = 0; i < bubbles; i++) {
		var dist = random_range(-hit_magnitude*0.05, hit_magnitude*0.05) + 2*hit_magnitude/point_distance(hit_point_x, hit_point_y, bubble_points[i][0], bubble_points[i][1]);
		var dir = point_direction(hit_point_x, hit_point_y, bubble_points[i][0], bubble_points[i][1]);
		draw_sprite(sBubbles, bubble_index[i], bubble_points[i][0] + lengthdir_x(dist, dir)
		,bubble_points[i][1] + 2*dsin(current_time *0.2 + i*30) + lengthdir_y(dist, dir));	
	}
}

//draw_circle(hit_point_x, hit_point_y, hit_magnitude, false);