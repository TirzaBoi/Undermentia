// *hey papaya *WHAT? *i think made spaghetti *THINK? LET ME SEE... 
// *OH MY GOD WHAT IS THAT SANDS??! *its spaghetti, spaghetti code

// But actually, its not the best system with how many global variables i made, but it sure works... for now.

 if (place_meeting(x, y, obj_player) and global._isFalling == false) {
	global._isFalling = true
	audio_play_sound(snd_fall_down_a_hole, 6, false);
	sprite_index = Cracked_Tile_Open
 } 