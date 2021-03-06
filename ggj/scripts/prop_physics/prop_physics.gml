// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function init_physics() {
	if (!instance_exists(oPhysics)) {
		instance_create_depth(0,0,0,oPhysics);	
	}
}

#region points
function verlet_point_init() {
	physics_visible = true;
	
	prev_pos_x = x;
	prev_pos_y = y;
	forces_x = 0;
	forces_y = 0;

	link_count = 0;

	//drag should be a value between 0 and 1 and will be resistance to movement (0 = will not move, 1 = no resistance)
	drag = 0.98; 

	//use script verlet_part_set_mass(m) to set the mass, dont set directly
	mass = 1;
	inv_mass = 1/mass;
	
	detached = false;
	detached_from_main = false;
	detachment_force = 0;
	
	custom_gravity = false;
	xgrav = 0;
	ygrav = 0;
	
	life = 0;
	
	physics_active = false;
}

function verlet_point_update() {
	if !physics_active return;
	
	var temp_x = x;
	var temp_y = y;

	x += (x-prev_pos_x) * drag + forces_x * inv_mass;
	y += (y-prev_pos_y) * drag + forces_y * inv_mass;
	prev_pos_x = temp_x;
	prev_pos_y = temp_y;
	forces_x = 0;
	forces_y = 0;
}

function verlet_point_apply_force(force_x, force_y) {
	if !physics_active return;

	forces_x += force_x;
	forces_y += force_y;
}

function verlet_point_apply_gravity(grav, wind) {
	if !physics_active return;
	
	if custom_gravity {
		forces_x += xgrav;
		forces_y += ygrav;
	}
	
	switch global.down_direction {
		case 0:	  
		forces_x -= grav;
		forces_y += wind;
		break;
		case 90:  
		forces_x -= wind;
		forces_y -= grav;
		break;
		case 180: 
		forces_x += grav;
		forces_y -= wind;
		break;
		case 270: 
		forces_x += wind;
		forces_y += grav;
		break;
	}
}

function verlet_point_set_mass(argument0, argument1) {
	var part = argument0;
	part.prev_mass = part.mass;
	part.mass = argument1;
	if(part.mass > 0){
	    part.inv_mass = 1 / part.mass;
	} else {
	    part.mass = 0;
	    part.inv_mass = 0;
	}
}

function verlet_point_set_custom_gravity(p, xx,yy) {
	p.custom_gravity = true;
	p.xgrav = xx;
	p.ygrav = yy;
}

function verlet_point_do_collision() {
	if !physics_active return;

	if (mass == 0) return;
	
	if (place_meeting(x,y,global.active_player_object)) {
		var x_force = global.active_player_object.x - global.active_player_object.physics_xprevious;
		var y_force = global.active_player_object.y - global.active_player_object.physics_yprevious;
		
		x_force *= global.active_player_object.physics_mass*inv_mass;
		y_force *= global.active_player_object.physics_mass*inv_mass;
		verlet_point_apply_force(x_force, y_force);		
	}
	
	var inst = instance_place(x,y,pMovableSolid) 
	if (inst != noone and (inst.hsp != 0 or inst.vsp != 0)) {
		var x_force = inst.x - inst.physics_xprevious;
		var y_force = inst.y - inst.physics_yprevious;
		
		x_force *= inst.physics_mass*inv_mass;
		y_force *= inst.physics_mass*inv_mass;
		verlet_point_apply_force(x_force, y_force);		
	}	
}
#endregion
	
#region spring
function verlet_spring_init() {
	physics_visible = false;
	
	point_a = noone;
	point_b = noone;	
	resting_distance = 0;
	strength = 1.0;
	
	// tear threshold -- very high normally
	tear_threshold = -1;
	tear_resistance = 1.0;
}

function verlet_spring_set(spring, pa, pb, dist) {
	spring.point_a = pa;
	spring.point_b = pb;	
	pa.link_count++;
	pb.link_count++;

	spring.resting_distance = dist;	

}

function verlet_spring_update() {
	if !instance_exists(point_a) or !instance_exists(point_b) {
		if (instance_exists(point_a)) point_a.detached = true;
		if (instance_exists(point_b)) point_b.detached = true;
		instance_destroy();	
		return;
	}
	
	if (point_a.physics_active && point_b.physics_active){
	    var dx = point_b.x - point_a.x;
	    var dy = point_b.y - point_a.y;
	    var delta_length = sqrt(dx*dx+dy*dy);
		var dir = point_direction(0,0,dx,dy);
		
	    if(delta_length > 1){
	        var diff = (delta_length - resting_distance) / (delta_length*(point_a.inv_mass+point_b.inv_mass));
	        diff *= strength;
	        point_a.x += point_a.inv_mass * dx * diff;
	        point_a.y += point_a.inv_mass * dy * diff;
	        point_b.x -= point_b.inv_mass * dx * diff;
	        point_b.y -= point_b.inv_mass * dy * diff;
			point_a.image_angle = dir;
			point_b.image_angle = dir;
	    }
		
		if (delta_length > tear_threshold and tear_threshold != -1) {
			instance_destroy();
			
			// propagate detachments
			point_b.detached = true;
			point_b.detachment_force = ceil(0.5*(delta_length-tear_threshold)/tear_resistance);
																			 
			point_a.detached = true;										 
			point_a.detachment_force = ceil(0.5*(delta_length-tear_threshold)/tear_resistance);
		}
		
		if (point_a.detached and tear_threshold != -1) {
			instance_destroy();
			
			if (point_a.detachment_force > 0) {
				point_b.detached = true;
				point_b.detachment_force = point_a.detachment_force-1;
			}
		}
		
		if (point_b.detached and tear_threshold != -1) {
			instance_destroy();
			
			if (point_b.detachment_force > 0) {
				point_a.detached = true;
				point_a.detachment_force = point_b.detachment_force-1;
			}
		}
		
	}
}
#endregion