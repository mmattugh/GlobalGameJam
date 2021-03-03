speed = lerp(speed,0,0.05);

switch global.down_direction {
	case 270:
	y += vsp;
	break;
	case 0:
	x -= vsp;
	break;
	case 90:
	y -= vsp;
	break;
	case 180:
	x += vsp;
	break;
}