/// @description 

//var iterations = 50;

//for (var i = 0; i < iterations; i++) {
//	with oPhysicsPointMass {
//		solve_links();	
//	}
//}

with oPhysicsPointMass {
	if (collides) {
		verlet_point_do_collision();	
		//verlet_point_do_solid();
	}
}

var constraint_iterations = 5;
for (var i = 0; i < constraint_iterations; i++) {
	with oPhysicsLink {
		verlet_spring_update()	
	}
}

with oPhysicsPointMass {
	//verlet_point_uncollide(id, Solid);
	verlet_point_apply_gravity(0.5);
	verlet_point_update();	
}

#region destroy useless object
with oPhysicsPointMass {
	if (detached) {
		drag = 0.95
		image_alpha = approach(image_alpha, 0, 0.01);
		
		if (image_alpha == 0) instance_destroy();
	}
	
	if (x > room_width or y > room_height or x < 0 or y < 0) {
		instance_destroy();	
	}
}

with oPhysicsLink {
	if (!instance_exists(point_b) or !instance_exists(point_a)) {
		instance_destroy();
	}	
}
#endregion

with oCharacter {
	physics_xprevious = x
	physics_yprevious = y
}

with pMovableSolid {
	physics_xprevious = x
	physics_yprevious = y	
}