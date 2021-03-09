/// @description 

//var iterations = 50;

//for (var i = 0; i < iterations; i++) {
//	with oPhysicsPointMass {
//		solve_links();	
//	}
//}

with oPhysicsLink {
	verlet_spring_update()	
}

with oPhysicsLink {
	if (!instance_exists(point_b) or !instance_exists(point_a)) {
		instance_destroy();
		return;
	}	
}

with oPhysicsPointMass {
	if (collides) {
		verlet_point_do_collision();	
		//verlet_point_do_solid();
	}
	//verlet_point_uncollide(id, Solid);
	verlet_point_apply_gravity(0.5);
	verlet_point_update();	
}


with oCharacter {
	physics_xprevious = x
	physics_yprevious = y
}

with pMovableSolid {
	physics_xprevious = x
	physics_yprevious = y	
}