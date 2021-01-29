image_alpha = 0.5;
image_speed = 0;
image_angle_initial = oCharacter.draw_angle;
sprite_index = oCharacter.sprite_index;
image_xscale = oCharacter.flipped;

// small randomization
image_angle_offset = random_range(-5, 5);

image_angle = image_angle_initial + image_angle_offset;