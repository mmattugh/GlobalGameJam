/// @description Insert description here
// You can write your code in this editor

for (var i = 0; i < sprite_width; i+=8) {
for (var j = 0; j < sprite_height;j+=8) {
	with instance_create_depth(x+i,y+j,depth+1,choose(fxSmoke,fxSmoke,fxSmokeLarge))
	{
		direction = random_range(75,105)
		speed = random_range(1,3)
	}
}
}