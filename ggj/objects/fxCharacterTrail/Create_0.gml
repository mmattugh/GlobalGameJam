image_alpha = 0.5;
image_speed = 0;
image_angle_initial = global.active_player_object.draw_angle;
sprite_index = global.active_player_object.sprite_index;
image_xscale = global.active_player_object.flipped;

// small randomization
image_angle_offset = random_range(-5, 5);

image_angle = image_angle_initial + image_angle_offset;