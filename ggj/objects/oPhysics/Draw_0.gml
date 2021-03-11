/// @description Insert description here
// You can write your code in this editor
with oPhysicsPointMass {
	if (physics_active)
		event_perform(ev_draw,0);	
}

with oPhysicsLink {
	event_perform(ev_draw,0);	
}