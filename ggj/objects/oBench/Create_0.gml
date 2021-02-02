/// @description 
depth = depth+1;
if (instance_exists(oMusic)) {
	with oMusic {
		audio_stop_sound(track_id);
		audio_stop_sound(muffled_track_id);
		audio_stop_sound(wobbly_track_id);
		instance_destroy();
	}
}

made_music_obj = false;
red = make_color_rgb(201, 99, 99);

text_y = y;
text_x = x;

x_offsets = [-70, -290, 100];
y_offsets = [-150, 0, 120]
angles = [15, 5, -5]
scales = [3.0, 2.5, 2.0];

text[0] = "take a break";
text[1] = "look at space";
text[2] = "press ";

continue_pressed = false;
made_particles = false;
made_particles_2 = false;


if (global.gamepad_is_connected and !global.gamepad_is_xbox) {
	text[2] += 	"square ";
} else {
	text[2] += "x ";	
}

text[2] += "to continue";