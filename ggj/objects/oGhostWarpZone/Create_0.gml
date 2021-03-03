/// @description 

hit_point_x = 0
hit_point_y = 0;
hit_magnitude_max = 300;
hit_magnitude = 0;

hit_by_ghost = false;
	hit_by_player = false;	
	
bubble_points = [];
bubble_index = [];
bubbles = 0;

create_hit_particles = function() {
	repeat (20) {
		with instance_create_depth(hit_point_x+random_range(-16, 16),hit_point_y+random_range(-16, 16),depth-1,choose(fxSmoke,fxSmoke,fxSmokeLarge))
		{
			direction = random_range(75,105)+270-global.down_direction
			speed = random_range(1,3)
			image_speed = 0.5;
		}
	}	
}


// build format
//vertex_format_begin();
//vertex_format_add_position();
//vertex_format_add_texcoord();
//format = vertex_format_end()
//vertex_buffer = vertex_create_buffer();
//texture = sprite_get_texture(sprite_index, 0);

//var uvs = texture_get_uvs(texture);
var step = 4;
var w = sprite_width;
var h = sprite_height;

//vertex_begin(vertex_buffer, format);

for (var i = 0; i < w ; i+=step) {
for (var j = 0; j < h; j+=step) {
	// cull obscured parts of zone
	if !instance_position(x+i,y+j,oWall) {
		
		if (chance(10)) {
			bubble_points[bubbles] = [x+i, y+j];
			bubble_index[bubbles] = irandom(3);
			bubbles++;
		}
		
		#region make triangle
		//var uv;	
		//uv[0] = uvs[0] + uvs[2] * i/w;
		//uv[2] = uvs[0] + uvs[2] *(i+1)/w;
		
		//uv[1] = uvs[1] + uvs[3] * j/h;
		//uv[3] = uvs[1] + uvs[3] *(j+1)/h;
		
		//vertex_position(vertex_buffer, x+i, y+j);
		//vertex_texcoord(vertex_buffer, uv[0], uv[1]);
		
		//vertex_position(vertex_buffer, x+i+step, y+j);
		//vertex_texcoord(vertex_buffer, uv[2], uv[1]);

		//vertex_position(vertex_buffer, x+i+step, y+j+step);
		//vertex_texcoord(vertex_buffer, uv[2], uv[3]);
		
		//vertex_position(vertex_buffer, x+i, y+j);
		//vertex_texcoord(vertex_buffer, uv[0], uv[1]);
		
		//vertex_position(vertex_buffer, x+i, y+j+step);
		//vertex_texcoord(vertex_buffer, uv[0], uv[3]);

		//vertex_position(vertex_buffer, x+i+step, y+j+step);
		//vertex_texcoord(vertex_buffer, uv[2], uv[3]);
		#endregion
	}
}	
}

//vertex_end(vertex_buffer);
//vertex_freeze(vertex_buffer);


