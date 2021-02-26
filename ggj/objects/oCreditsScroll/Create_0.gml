/// @description 

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

// section 1: helpers
header[1] = "additional help"
var i = 0;
text[1][i++] = "zedsquadron";
text[1][i++] = "jakefriend";
text[1][i++] = "milkbarjack";

footer[1] = "";

// section two: playtester boys
header[2] = "playtesters";

var i = 0;
text[2][i++] = "zedsquadron";
text[2][i++] = "chris"
text[2][i++] = "luke"
text[2][i++] = "brock"
text[2][i++] = "dietzribi"
text[2][i++] = "clement"
text[2][i++] = "connor"
text[2][i++] = "patrick"
text[2][i++] = "jarred"
text[2][i++] = "noah"
text[2][i++] = "brock"
text[2][i++] = "kurtis"

footer[2] = "";
// section three: special boys
header[3] = "special thanks";

if NG_ENABLED {
	text[3][0] = "tom fulp";
	text[3][1] = "and no one else";
} else if ITCH_ENABLED {
	text[3][0] = "leafo";
	text[3][1] = "and no one else";	
} else {
	text[3][0] = "no one";
}

if global.gamepad_connected and global.gamepad_is_xbox == false {
	footer[3] = "press square ";	
} else {
	footer[3] = "press x ";
}	
footer[3] += "to continue";

sections = array_length(header);