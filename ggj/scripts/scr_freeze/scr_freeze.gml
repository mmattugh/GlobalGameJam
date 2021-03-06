function scr_freeze(argument0) {
	var _freezedur = argument0;
	var _t = min(_freezedur, global.screen_freeze_max-global.screen_freeze_this_frame);

	var _f = floor(_t * 60/1000)
	global.game_world_paused = _f;
	
	//_t -= _f * 1000/60;

	//while (current_time < _t)
	//{
	//		// do input buffering during freeze frames
	//	with oController {
	//		global.key_jump = oController.check_binding(input_keys.jump);
	//		global.key_interact = oController.check_binding(input_keys.interact);
	//	}
	//};


}
