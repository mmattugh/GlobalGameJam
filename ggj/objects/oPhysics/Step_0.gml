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
		var x_force = global.active_player_object.x - oPhysics.player_x_prev;
		var y_force = global.active_player_object.y - oPhysics.player_y_prev;
		verlet_part_apply_force(x_force, y_force);		
	}
	//verlet_point_uncollide(id, Solid);
	verlet_part_apply_force(0, 0.5);
	verlet_point_update();	
}

player_x_prev = global.active_player_object.x;
player_y_prev = global.active_player_object.y;