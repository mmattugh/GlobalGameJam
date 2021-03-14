/// @description Insert description here
// You can write your code in this editor

for (var j = 0; j < hh; j+=1) {
	for (var i = 0; i < ww; i+=1) {
		var p;
		p[1] = points[j][i];
		p[2] = points[j][i+1];
		p[3] = points[j+1][i];
		p[4] = points[j+1][i+1];
		
		if (p[1] != false and instance_exists(p[1])) {
			draw_sprite_ext(sClothPoint, 0, p[1].x, p[1].y, p[1].draw_xscale, p[1].draw_xscale, p[1].image_angle, c_white, 1.0);	
		}
		
		if !(instance_exists(p[1])) p[1] = false;
		if !(instance_exists(p[2])) p[2] = false;
		if !(instance_exists(p[3])) p[3] = false;
		if !(instance_exists(p[4])) p[4] = false;

		if p[1] and (p[1].detached) { p[1].physics_visible = true; points[j][i] = false;	  }
		if p[2] and (p[2].detached) { p[2].physics_visible = true; points[j][i+1] = false;	  }
		if p[3] and (p[3].detached) { p[3].physics_visible = true; points[j+1][i] = false;	  }
		if p[4] and (p[4].detached) { p[4].physics_visible = true; points[j+1][i+1] = false;	  }
		
		if (p[1] and p[2] and p[3] and p[4]) 
		{
			draw_sprite_pos(sprite_index, 0, p[1].x, p[1].y, p[2].x, 
			p[2].y, p[4].x, p[4].y, p[3].x, p[3].y, 1.0);	
		} else {
			var c = 0;
			for (var i = 1; i <= 4; i++) {
				if (p[i]) c++;	
			}
			
			if (c == 3) {	
				var index = 0;
				var p1x = (p[1])? p[1].x : 0;
				var p1y = (p[1])? p[1].y : 0;
				var p2x = (p[2])? p[2].x : 0;
				var p2y = (p[2])? p[2].y : 0;
				var p3x = (p[3])? p[3].x : 0;
				var p3y = (p[3])? p[3].y : 0;
				var p4x = (p[4])? p[4].x : 0;
				var p4y = (p[4])? p[4].y : 0;

				if (!p[1]) {
					p1x = p3x;
					p1y = p2y;
					index = 1;
				} else if (!p[2]) {
					p2x = p4x;
					p2y = p1y;
					index = 2;
				} else if (!p[3]) {
					p3x = p1x;
					p3y = p4y;
					index = 3;
				} else if (!p[4]) {
					p4x = p2x;
					p4y = p3y;
					index = 4;
				}
				
				//if (point_distance(p1x, p1y, p3x, p3y) > sprite_width)
				//or (point_distance(p2x, p2y, p4x, p4y) > sprite_width)
				//{
				//	p[3].physics_visible = true;
				//	p[4].physics_visible = true;
				//	points[j+1][i] = false;
				//	points[j+1][i+1] = false;
				//} else {
					draw_sprite_pos(sprite_index, index,
					p1x, p1y, p2x, p2y, 
					p4x, p4y, p3x, p3y, 1.0);
				//}
			}
		}
		
	}
}

draw_sprite(sClothPoint, 1, point_locked_1.x, point_locked_1.y)
draw_sprite(sClothPoint, 1, point_locked_2.x, point_locked_2.y)