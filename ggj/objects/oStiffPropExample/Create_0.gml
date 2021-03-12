/// @description Insert description here
// You can write your code in this editor


var length = 30+random(5);
var nodes = 5;

var p1, p2, link;
p1 = instance_create_depth(x,y,depth,oPhysicsPointMass);
verlet_point_set_mass(p1, 0)

// used to add "stiffnes" to the prop
verlet_point_set_custom_gravity(p1, 0, -2)

for (var i = 0; i <= length; i += length/nodes) {
	p2 = instance_create_depth(x,y-i,depth,oPhysicsPointMass);
	verlet_point_set_mass(p2, 4.0)
	verlet_point_set_custom_gravity(p2, 0, -2)

	link = instance_create_depth(0,0,depth,oPhysicsLink);
	verlet_spring_set(link, p1, p2, length/nodes);
	
	p1 = p2;
}

//if (choose(true, false)) {
//	verlet_point_set_mass(p2, 0)
//}
