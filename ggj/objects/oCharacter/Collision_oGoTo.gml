if (state != pStates.freeze) {
	state = pStates.freeze;

	instance_create_depth(0,0,depth,oRoomTransition);
	
	// save
	
	ini_open(SAVE_FILE);

	ini_write_real("save", room_get_name(room), 1.0);
	
	var rooms  = ini_read_real("save", "rooms", 0);
	if (global.rooms > rooms) {
		ini_write_real("save", "latest_room", room);
		ini_write_real("save", "rooms", global.rooms);
		//show_message("saved" + string(room));
	}

	ini_close();
	
}

