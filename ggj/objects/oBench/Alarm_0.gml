
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


if (global.gamepad_is_connected) {
	if (global.gamepad_is_xbox) {
		text[2] += "x ";	
	} else {
		text[2] += 	"square ";	
	}
} else {
	text[2] += "x ";	
}

text[2] += "to continue";