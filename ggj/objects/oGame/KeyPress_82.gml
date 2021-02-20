/// @description Insert description here
// You can write your code in this editor
//if DEV_MODE
if (global.speedrun and keyboard_check(vk_lcontrol)) {
	game_restart();
}

if (room != level_intermission)
	room_restart();