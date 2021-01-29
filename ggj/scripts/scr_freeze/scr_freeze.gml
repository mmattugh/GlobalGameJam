function scr_freeze(argument0) {
	var _freezedur = argument0;
	var _t = current_time + min(_freezedur, global.screen_freeze_max-global.screen_freeze_this_frame);

	while (current_time < _t)
	{
	
	};


}
