
if (instance_exists(oCharacter))
{


// check destroyed
if !instance_exists(station_object) {
	station_object = noone;
}


// get state and zoom info
if (station_object != noone) {
	state = station_object.zone_type;	
	target_zoom = station_object.zoom;
} else {
	state = cStates.follow;
	target_zoom = 1.0;
}

#region set follow target
switch oCharacter.state {
	
	case pStates.ghost:
	follow_object = oGhost;
	break;
	case pStates.move:
	case pStates.death:
	follow_object = oCharacter;
	break;
	case pStates.follow_trail:
	case pStates.launch_from_trail:
	follow_object = oCharacterGhostAverage;
	break;
}

#endregion

#region state machine
if instance_exists(follow_object) {
	switch state { 
		case cStates.follow	: 
		target_x = follow_object.x;
		target_y = follow_object.y;
		break;
		case cStates.follow_x: 
		target_x = follow_object.x;
		target_y = station_object.y;
		break;	
		case cStates.follow_y: 
		target_x = station_object.x;
		target_y = follow_object.y;
		break;	
		case cStates.centered: 
		target_x = station_object.x;
		target_y = station_object.y;	
		break;	
	}
}
#endregion

// calculate camera size, with zoom
var true_width = zoom*global.camera_width;
var true_height= zoom*global.camera_height;

// clamp to room
target_x = clamp(target_x, true_width/2 , room_width -true_width/2);
target_y = clamp(target_y, true_height/2, room_height-true_height/2);
zoom = lerp(zoom, target_zoom, zoom_lerp);

// move to target_position
x = lerp(x, target_x, follow_lerp);
y = lerp(y, target_y, follow_lerp);

var view_x = x-true_width/2;
var view_y = y-true_height/2;

#region screenshake
if (screenshake > 0) {
	view_x += random_range(screenshake/2, screenshake)*choose(-1,1)*global.screenshake_intensity;
	view_y += random_range(screenshake/2, screenshake)*choose(-1,1)*global.screenshake_intensity;
	
	screenshake = approach(screenshake, 0, screenshake_decrease);
	
	if (screenshake > screenshake_curve_threshold) {
		screenshake *= screenshake_curve;	
	}
}
#endregion

camera_set_view_size(camera, true_width, true_height);
camera_set_view_pos(camera, view_x, view_y);

#region parallax

layer_x("Planet", (x-true_width /4)*1);
layer_y("Planet", (y-true_height/4)*1);

layer_x("BigStars", x*0.95);
layer_y("BigStars", y*0.95);

layer_x("SmallStars", x*0.93);
layer_y("SmallStars", y*0.93);

#endregion

}