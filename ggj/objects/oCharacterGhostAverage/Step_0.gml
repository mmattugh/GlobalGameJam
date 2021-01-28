/// @description 
if (instance_exists(oGhost)) {
	x = (oCharacter.x*0.25 + oGhost.x*0.75);
	y = (oCharacter.y*0.25 + oGhost.y*0.75);
} else {
	x = oCharacter.x;	
	y = oCharacter.y;
}	