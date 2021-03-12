/// @description Insert description here
// You can write your code in this editor
visible = false;

var length = sprite_width;
var nodes = (length/sprite_get_height(sChainLink));

var p1, p2, link, xstep, ystep;
xstep = lengthdir_x(1, image_angle);
ystep = lengthdir_y(1, image_angle);

p1 = instance_create_depth(x,y,depth,oPhysicsChainLink);
verlet_point_set_mass(p1, 0)

var j = 0;
for (var i = 0; i <= length; i += length/nodes) {
	p2 = instance_create_depth(x+i*xstep,y+i*ystep,depth,oPhysicsChainLink);
	verlet_point_set_mass(p2, 4.0)
	
	if j++ mod 2 == 0 {
		p2.angle_offset = 90;	
		p2.collides = false;
	}

	link = instance_create_depth(0,0,depth,oPhysicsLink);
	verlet_spring_set(link, p1, p2, length/nodes);
	link.visible = false;
	
	p1 = p2;
}

if (collision_point(x+sprite_width*xstep, y+sprite_height*ystep, Solid, false, false)) {
	verlet_point_set_mass(p2, 0)
}
