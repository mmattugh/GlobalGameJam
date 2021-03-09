/// @description Insert description here
// You can write your code in this editor


var length = 70;
var nodes = 10;

var p1, p2, link;
p1 = instance_create_depth(x,y,depth,oPhysicsPointMass);
verlet_point_set_mass(p1, 0)

for (var i = 0; i <= length; i += length/nodes) {
	p2 = instance_create_depth(x+i,y,depth,oPhysicsPointMass);
	verlet_point_set_mass(p2, 4.0)

	link = instance_create_depth(0,0,depth,oPhysicsLink);
	verlet_spring_set(link, p1, p2, length/nodes);
	
	p1 = p2;
}

if (choose(true, false)) {
	verlet_point_set_mass(p2, 0)
}
