// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function init_physics() {
	if (!instance_exists(oPhysics)) {
		instance_create_depth(0,0,0,oPhysics);	
	}
}

#region points
function verlet_point_init() {
	prev_pos_x = x;
	prev_pos_y = y;
	forces_x = 0;
	forces_y = 0;

	//drag should be a value between 0 and 1 and will be resistance to movement (0 = will not move, 1 = no resistance)
	drag = 0.98; 

	//use script verlet_part_set_mass(m) to set the mass, dont set directly
	mass = 1;
	inv_mass = 1;
	
	life = 0;
}

function verlet_point_update() {
	var temp_x = x;
	var temp_y = y;

	x += (x-prev_pos_x) * drag + forces_x * inv_mass;
	y += (y-prev_pos_y) * drag + forces_y * inv_mass;
	prev_pos_x = temp_x;
	prev_pos_y = temp_y;
	forces_x = 0;
	forces_y = 0;
}

function verlet_part_apply_force(force_x, force_y) {
	forces_x += force_x;
	forces_y += force_y;
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

function verlet_point_uncollide(point, obj) {
	var inst = instance_place(point.x,point.y,obj); 
	if (inst) {
		var dir = point_direction(inst.x,inst.y,point.x,point.y);
		//var w = sprite_get_width(point.sprite_index);
		var w = 1;
		while (place_meeting(point.x,point.y,obj)) {
			point.x += lengthdir_x(w,dir);
			point.y += lengthdir_y(w,dir);	
		}
	}
}

#endregion
	
#region spring
function verlet_spring_init() {
	point_a = noone;
	point_b = noone;	
	resting_distance = 0;
	strength = 1.0;
}

function verlet_spring_set(spring, pa, pb, dist) {
	spring.point_a = pa;
	spring.point_b = pb;	
	spring.resting_distance = dist;	

}

function verlet_spring_update() {
	if(point_a != noone && point_b != noone){
	    var dx = point_b.x - point_a.x;
	    var dy = point_b.y - point_a.y;
	    var delta_length = sqrt(dx*dx+dy*dy);
	    if(delta_length > 1){
	        var diff = (delta_length - resting_distance) / (delta_length*(point_a.inv_mass+point_b.inv_mass));
	        diff *= strength;
	        point_a.x += point_a.inv_mass * dx * diff;
	        point_a.y += point_a.inv_mass * dy * diff;
	        point_b.x -= point_b.inv_mass * dx * diff;
	        point_b.y -= point_b.inv_mass * dy * diff;
	    }
	}
}
#endregion