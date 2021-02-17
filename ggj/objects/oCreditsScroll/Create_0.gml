/// @description 

white = make_color_rgb(225, 229, 206);
red = make_color_rgb(201, 99, 99);

text_y = global.camera_height*1.25;

// section one: the big boys
header[0] = "a game by";

text[0][0] = "mmatt_ugh";
subtext[0][0] = "designer artist";

text[0][1] = "dev_dwarf";
subtext[0][1] = "programmer";

text[0][2] = "connor grail";
subtext[0][2] = "sound music";

footer[0] = "support us by donating on itch.io";

// section two: playtester boys
header[1] = "playtesters";

text[1][0] = "zedsquadron";

footer[1] = "";
// section three: special boys
header[2] = "special thanks";

text[2][0] = "no one";
footer[2] = "";

sections = array_length(header);