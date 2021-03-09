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

with oPhysicsPointMass {
	if (place_meeting(x,y,global.active_player_object)) {
		var x_force = global.active_player_object.x - global.active_player_object.physics_xprevious;
		var y_force = global.active_player_object.y - global.active_player_object.physics_yprevious;
		verlet_point_apply_force(x_force, y_force);		
	}
	
	var inst = instance_place(x,y,pMovableSolid) 
	if (inst != noone and (inst.hsp != 0 or inst.vsp != 0)) {
		var x_force = inst.x - inst.physics_xprevious;
		var y_force = inst.y - inst.physics_yprevious;
		verlet_point_apply_force(x_force, y_force);		
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