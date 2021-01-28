///@desc angle_lerp
///@param in
///@param target
///@param percent
function angle_lerp(argument0, argument1, argument2) {
	var angle = (argument0 - angle_difference(argument0, argument1) * argument2)

	while(angle < 0) angle+=360;
	while(angle >= 360) angle -= 360;

	return angle;
}

///@desc approach
///@param in
///@param target
///@param difference
function approach(argument0, argument1, argument2) {
	var start, ending, difference, result;
	start = argument0;
	ending = argument1;
	difference = argument2;
	if (start < ending){
	    result = min(start + difference, ending);
	} else {
	    result = max(start - difference, ending);
	}
	return result;
}


///@param percent
function chance(argument0) {
	return (random(100) <= argument0);
}