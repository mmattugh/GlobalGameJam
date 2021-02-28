/// @description Insert description here
mask_index = sprite_index;
image_speed = 1;
if (place_meeting(x,y,Solid) or !instance_exists(oGhost)) {
	sprite_index = sGhostSpikesDown;
	mask_index = sNothing;
} else {
	sprite_index = sGhostSpikes;
	mask_index = sprite_index;
}