/// @description Insert description here
// You can write your code in this editor

var step = 6;
for (var j = 0; j < 10; j++) {
	for (var i = 0; i < 6; i++) {
		var newi = instance_create_depth(x+i*step,y+j*step,depth,oPhysicsPointMass);
		
		var inst = instance_place(x+(i-1)*step, y+j*step, oPhysicsPointMass);
		if (inst) {
			link = instance_create_depth(0,0,depth,oPhysicsLink);
			verlet_spring_set(link, inst, newi, step);	
			link.tear_threshold = step*4;
			//link.tear_resistance = .10;

		}
		
		var inst = instance_place(x+i*step, y+(j-1)*step, oPhysicsPointMass);
		if (inst) {
			link = instance_create_depth(0,0,depth,oPhysicsLink);
			verlet_spring_set(link, inst, newi, step);	
			link.tear_threshold = step*4;
			//link.tear_resistance = .10;
		}
	}
}

var inst = instance_place(x,y,oPhysicsPointMass);
if (inst) {
	verlet_point_set_mass(inst, 0)
}

var inst = instance_place(x+5*step,y,oPhysicsPointMass);
if (inst) {
	verlet_point_set_mass(inst, 0)
}