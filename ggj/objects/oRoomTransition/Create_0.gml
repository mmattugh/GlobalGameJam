/// @description 
target_room = noone;
state = 0;

out_duration = 7;
in_duration = 7;

delay = 7;

if (global.speedrun) {
	timer_step = 0.4;
} else {
	timer_step = 0.2;
}
timer = 0;

bg_color = make_color_rgb(36, 34, 35);

