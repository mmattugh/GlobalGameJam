/// @description 


if (orientation == 1) {
	image_index = approach(image_index, 0, 1/transition_time);
} else if (orientation == -1) {
	image_index = approach(image_index, image_number-1, 1/transition_time);
}