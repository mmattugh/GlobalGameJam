global.animationSpeed += 0.15;

if global.speedrun and (instance_exists(oCharacter) and oCharacter.state != pStates.freeze and !instance_exists(oCutsceneHand)) {
	global.speedrun_time++;
}