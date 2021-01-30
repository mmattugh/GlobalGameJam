/// @description 

draw_set_color(bg_color);
switch state {
	case 0:
	var s = 32;
	var w = global.camera_width/s;
	var h = global.camera_height/s;
	for (var i = 0; i < w; i++) {
	for (var j = 0; j < h; j++) {
		if ((i+j)/(w+h) > timer/out_duration) {
			continue;
		}
		
		if ((i+j+1)/(w+h) > timer/out_duration) {
			var f = frac(timer);
			var a = 0;//-45*(1-f)
			
			draw_sprite_ext(sBGRed, 0, (i+0.5)*s, (j+0.5)*s, s*f/2, s*f/2, a, c_white, 1.0);
		} else {//					+ 05		  +0.5
			var sp = sBG;
			//if ((i+j) mod 4) sp = sBGRed;
			draw_sprite_ext(sp, 0, (i+0.5)*s, (j+0.5)*s, s/2, s/2, 0, c_white, 1.0);
		}
	}
	}
	break;
	case 1:
	var s = 32;
	var w = global.camera_width/s;
	var h = global.camera_height/s;
	for (var i = 0; i < w; i++) {
	for (var j = 0; j < h; j++) {
		if ((i+j)/(w+h) > timer/in_duration) {
			continue;
		}
		
		if ((i+j+1)/(w+h) > timer/in_duration) {
			var f = frac(timer);
			var a = 0;//45*(1-f)
			
			draw_sprite_ext(sBGRed, 0, (w-i-0.5)*s, (h-j-0.5)*s, s*f/2, s*f/2, a, c_white, 1.0);
		} else {//					+ 05-		  +0.-
			var sp = sBG;
			//if ((i+j) mod 4) sp = sBGRed;
			draw_sprite_ext(sp, 0, (w-i-0.5)*s, (h-j-0.5)*s, s/2, s/2, 0, c_white, 1.0);
		}
	}
	}
	break;
}