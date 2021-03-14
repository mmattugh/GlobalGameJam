/// @description Insert description here
// You can write your code in this editor


var step = 7;
ww = 6;
hh = 8;

points = array_create(hh+1, array_create(ww+1, false));
for (var j = 0; j < hh; j++) {
	for (var i = 0; i < ww; i++) {
		var newi = instance_create_depth(x+i*step,y+j*step,depth,oPhysicsPointMass);
		verlet_point_set_mass(newi, 3.0);
		newi.physics_visible = false;
		newi.sprite_index = sClothFragment;
		newi.image_speed = 0;
		newi.image_index = irandom(3);
		newi.draw_xscale = 1;
		
		points[j][i] = newi;
		
		var inst = instance_place(x+(i-1)*step, y+j*step, oPhysicsPointMass);
		if (inst) {
			link = instance_create_depth(0,0,depth,oPhysicsLink);
			verlet_spring_set(link, inst, newi, step);	
			//link.tear_threshold = clamp(step*1.*hh/(j+1), step*1.5, step*2);
			//link.tear_resistance = 2;
		}
		
		var inst = instance_place(x+i*step, y+(j-1)*step, oPhysicsPointMass);
		if (inst) {
			link = instance_create_depth(0,0,depth,oPhysicsLink);
			verlet_spring_set(link, inst, newi, step);	
			//link.tear_threshold = clamp(step*1.*hh/(j+1), step*1.5, step*2);
			//link.tear_resistance = 2;
		}
	}
}

//var j = irandom_range(hh-1, hh);
//var i = irandom(ww);
//instance_destroy(points[j][i]);
//points[j][i] = false;

point_locked_1 = instance_place(x,y,oPhysicsPointMass);
if (point_locked_1) {
	verlet_point_set_mass(point_locked_1, 0)
}

point_locked_2 =  instance_place(x+(ww-1)*step,y,oPhysicsPointMass);
if (point_locked_2) {
	verlet_point_set_mass(point_locked_2, 0)
}