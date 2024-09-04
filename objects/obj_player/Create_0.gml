name = "YAY";
lv = 1;
max_hp = 20;
cur_hp = 20; // current hp
gold = 0;
exper = 0; // experience
atk = 0; // attack
def = 0; // defense
atk_amp = 0; // attack amplifier
def_amp = 0; //defence amplifier
weap = false; // check if weapon is equipped
armor = false; // cheak if armor is equipped
//eq_armor = "none";
//eq_weap = "none";
eq_armor = global.item_list.bandage.name; // equipped armor name
eq_weap = global.item_list.stick.name; // equipped weapon name

#region Movement & Collision 

can_player_interact = true
movement_speed = 100;
is_moving = false;
dir = 0; 
enum DIRECTION {
	DOWN,
	LEFT,
	RIGHT,
	UP
}	

collided_trigger = undefined; // Stores a reference to a trigger object you are looking at
collided_length = 20; // Defines how far away you can grab a trigger object's reference
trigger_map = layer_tilemap_get_id("Triggers");
collision_map = layer_tilemap_get_id("Collision");

#endregion

#region Animation 

sprite_index = spr_player;
image_index = 0;

animation_frames = []
animation_speed = 0

animations = {
	down:	{ frames: [ 0, 3 ], speed: 6 },
	left:	{ frames: [ 4, 5 ], speed: 6 },
	right:	{ frames: [ 6, 7 ], speed: 6 },
	up:		{ frames: [ 8, 11], speed: 6 },
}

/* get_animation(): Takes an animation state and gets the frames & speed for use in the Draw call.
 *		_state: A passed animation state, used to index data from animations{}.
 */
function get_animation(_state) {
	passed_animation = animations[$ _state];
	animation_frames = passed_animation.frames;
	animation_speed = passed_animation.speed;
}

function create_empty_savedata() {
	global.savedata = ds_map_create();   // This is the full savedata, careful with access here
	global.progress = ds_map_create();   // This is specifically for any extra storage, go wild
	global.player_data =  ds_map_create();  // Situation-agnostic player data.
	ds_map_add_map(global.savedata, "player", global.player_data)
	ds_map_add_map(global.savedata, "progress",  global.progress)
	 fill_in_empty_savedata()
}

function fill_in_empty_savedata() {
	ds_map_add(global.player_data, "x", x)
	ds_map_add(global.player_data, "y", y)
	ds_map_add(global.player_data, "time", 0)
	ds_map_add(global.player_data, "room", room_get_name(rm_testbed))
	ds_map_add(global.player_data, "name", "CHARA")
	ds_map_add(global.player_data, "exp", 0)
	ds_map_add(global.player_data, "love", 0)
}

get_animation("down");

#endregion
