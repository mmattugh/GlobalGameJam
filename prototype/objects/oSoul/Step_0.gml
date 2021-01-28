
if (oCharacter.state != pState.spirit) {
	exit;	
}

this_frame++
current_path =  instance_create_depth(x,y,0,oSoulPath) 
with current_path {
	alarm[0] = 40 * (other.max_spd+1-other.spd);
	
	if (other.current_path == noone) {
		other.current_path = id;
	} else {
		other.current_path.next = id;
		other.current_path = id;
	}
}

if (place_meeting(x,y,oWall))
{
	oCharacter.state = pState.move;
	instance_destroy(oSoulPath);
	instance_destroy(self);
}
if (place_meeting(x,y,oSoulPath)) && (spd != 0)
{
	oCharacter.state = pState.move;
	instance_destroy(oSoulPath);
	instance_destroy(self);
}

if (place_meeting(x,y,oCharacter)) && (spd != 0)
{
	oCharacter.state = pState.move;
	instance_destroy(oSoulPath);
	instance_destroy(self);
}

image_index = image_angle * 0.1 - 9;
	
dir = image_angle;
	
if (place_meeting(x,y,oWall))
{
	image_alpha = image_alpha - 0.02;
}
else image_alpha = image_alpha - 0.001;
	
spd = approach(spd, max_spd, acceleration);
x = x + lengthdir_x(spd,dir);
y = y + lengthdir_y(spd,dir);

var angle_dir = global.key_left - global.key_right;
image_angle = angle_lerp(image_angle, image_angle + angle_dir * turnspd, turn_percent);		
if (angle_dir != 0) {
	spd = lerp(spd, 1.75, turn_slowdown);
}