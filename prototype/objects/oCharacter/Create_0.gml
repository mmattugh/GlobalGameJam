hsp = 0;
vsp = 0;
hspboost = 0;
vspboost = 0;

ammo = 1;

hsp_carry = 0;
walkSpeed = 2;
grvSpeed = 0.2;
jumpHeight = 4;

mytarget = noone;

falling = false;
fallStun = 0;

beingCarried = false;

//Draw
flipped = 1;
xscale_ = image_xscale;
yscale_ = image_yscale;

//State
state = pState.move;
enum pState
{
	move,
	spirit,
	prelaunch,
	launch,
}

spd = 0;
//FX
animationNumber = 0;