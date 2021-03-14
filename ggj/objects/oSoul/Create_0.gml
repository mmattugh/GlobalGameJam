image_index = random_range(0,12);
image_xscale = -1 or 1;
image_angle = random_range(0,360)

light = instance_create_depth(x,y,depth,oLight);
with light {
	radius = 50;
	color = make_color_rgb(20, 20, 150);	
}