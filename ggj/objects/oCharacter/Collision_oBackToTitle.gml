if (state != pStates.freeze) {
	state = pStates.freeze;

	instance_create_depth(0,0,depth,oRoomTransition);
	oRoomTransition.target_room = title_screen;
	
}

