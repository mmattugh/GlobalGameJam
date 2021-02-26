/// @description Insert description here
if (depth != 2) depth = 2;

// draw ghost warp zone on top
if (instance_exists(oGhostWarpZone)) {
	
	with oGhostWarpZone {
		event_perform(ev_draw, 0);
	}
	
	shader_reset();
}
