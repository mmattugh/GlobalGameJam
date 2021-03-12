/// @description 

//var iterations = 50;

//for (var i = 0; i < iterations; i++) {
//	with oPhysicsPointMass {
//		solve_links();	
//	}
//}
physics_wind = (1+dsin(current_time*45/12))*physics_wind_magnitude;
//physics_wind = physics_wind_magnitude;

view_x1 = camera_get_view_x(view_camera[0]);
view_y1 = camera_get_view_y(view_camera[0]);
view_x2 = view_x1 + camera_get_view_width(view_camera[0]);
view_y2 = view_y1 + camera_get_view_height(view_camera[0]);



with oPhysicsPointMass {
	physics_active = !other.near_screen();

	if (custom_update != noone) {
		custom_update();	
	}
	
	if (collides) {
		verlet_point_do_collision();	
		//verlet_point_do_solid();
	}
}

var constraint_iterations = 2;
for (var i = 0; i < constraint_iterations; i++) {
	with oPhysicsLink {
		verlet_spring_update()	
	}
}

with oPhysicsPointMass {
	//verlet_point_uncollide(id, Solid);
	verlet_point_apply_gravity(0.5, oPhysics.physics_wind);
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