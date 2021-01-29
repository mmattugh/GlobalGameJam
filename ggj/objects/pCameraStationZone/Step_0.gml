/// @description 
visible = false;


if (place_meeting(x,y,oCamera.follow_object)) {
	oCamera.station_object = id;	
} else {
	if (oCamera.station_object == id) {
		oCamera.station_object = noone;	
	}
}