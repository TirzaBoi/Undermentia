global.dialogues = [
	{
		text : "This is a testing dialogue.//This text is white,<color #FF0000>now it's red,<color #0000FF>now blue,</color>and red again,</color>ending in white.",
		font : fnt_default,
		txt_speed : 0.7,
		next : undefined,
		item : undefined,
		play : false,
		sound : undefined,
		loop : undefined,
		characters : [undefined, undefined],
		emotions : [],
		option1 : undefined,
		option2 : undefined,
		auto : false,
		voices : [sfx_talk_def, sfx_talk_def],
		colors : [],
		effects : []
	},
	{
		text : "It’s <color #FF00AA>Toriel's</color> diary.//read the circled passage?",
		font : fnt_default,
		txt_speed : 0.7,
		next : undefined,
		item : undefined,
		play : false,
		sound : undefined,
		loop : undefined,
		characters : [undefined, undefined],
		emotions : [],
		option1 : {
			text : "Yes",
			next : 1
		},
		option2 : {
			text : "No",
			next : 2
		},
		auto : false,
		voices : [sfx_talk_def, sfx_talk_def],
		colors : [],
		effects : []
	},
	{
		text : "You read the passage one. “Why did the skeleton want a friend? Because she was feeling BONELY!” The rest of the diary is filled with jokes with the same caliber",
		font : fnt_default,
		txt_speed : 0.7,
		next : undefined,
		item : undefined,
		play : false,
		sound : undefined,
		loop : undefined,
		characters : [undefined],
		emotions : [],
		option1 : undefined,
		option2 : undefined,
		auto : false,
		voices : [sfx_talk_def],
		colors : [],
		effects : []
	},
	{
		text : "",
		font : fnt_default,
		txt_speed : 0.7,
		next : undefined,
		item : undefined,
		play : false,
		sound : undefined,
		loop : undefined,
		characters : [undefined],
		emotions : [],
		option1 : undefined,
		option2 : undefined,
		auto : true,
		voices : [sfx_talk_def],
		colors : [],
		effects : []
	},
	{
		text : "Howdy! I'm Flowey. Flowey the Flower!//You're new to the underground, aren't cha?//Golly, you must be so confused.//Someone better teach you how things work around here.//I guess little old me will have to do.//Ready? Here we go!",
		font : fnt_default,
		txt_speed : 0.7,
		next : 1,
		item : undefined,
		play : false,
		sound : undefined,
		loop : undefined,
		characters : [spr_port_flour, spr_port_flour, spr_port_flour, spr_port_flour, spr_port_flour, spr_port_flour],
		emotions : [0, 1, 2, 3, 4, 5],
		option1 : undefined,
		option2 : undefined,
		auto : false,
		voices : [sfx_talk_flowey, sfx_talk_flowey, sfx_talk_flowey, sfx_talk_flowey, sfx_talk_flowey, sfx_talk_flowey],
		colors : [],
		effects : []
	},
	{
		text : "HOWDY! I'm Flowey! Flowey the Flower.//Teehee, I know what you did there.//You killed her.//And you regret it so you reset!//You think you can get away from me with anything you do?//You’ve gotta try harder than that buddy.",
		font : fnt_default,
		txt_speed : 0.7,
		next : 2,
		item : undefined,
		play : false,
		sound : undefined,
		loop : undefined,
		characters : [spr_port_flour, spr_port_flour, spr_port_flour, spr_port_flour, spr_port_flour, spr_port_flour],
		emotions : [0, 1, 2, 3, 4, 5],
		option1 : undefined,
		option2 : undefined,
		auto : false,
		voices : [sfx_talk_flowey, sfx_talk_flowey, sfx_talk_flowey, sfx_talk_flowey, sfx_talk_flowey, sfx_talk_flowey],
		colors : [],
		effects : []
	},
	{
		text : "Seriously?! I thought you were finally seeing things my way.//We could have had so much fun burning this world down together, then you chickened out.",
		font : fnt_default,
		txt_speed : 0.7,
		next : 3,
		item : undefined,
		play : false,
		sound : undefined,
		loop : undefined,
		characters : [spr_port_flour, spr_port_flour],
		emotions : [0, 1],
		option1 : undefined,
		option2 : undefined,
		auto : false,
		voices : [sfx_talk_flowey, sfx_talk_flowey],
		colors : [],
		effects : []
	},
	{
		text : "HOWDY! I'm Flowey! Flowey the Flower.//Huh? Why did you make me introduce myself?//Teehee, it’s rude to act like you don’t know me.//Someone ought to teach you how to use manners.",
		font : fnt_default,
		txt_speed : 0.7,
		next : 4,
		item : undefined,
		play : false,
		sound : undefined,
		loop : undefined,
		characters : [spr_port_flour, spr_port_flour, spr_port_flour, spr_port_flour],
		emotions : [0, 1, 2, 3],
		option1 : undefined,
		option2 : undefined,
		auto : false,
		voices : [sfx_talk_flowey, sfx_talk_flowey, sfx_talk_flowey, sfx_talk_flowey],
		colors : [],
		effects : []
	},
	{
		text : "Don’t you have anything better to do?",
		font : fnt_default,
		txt_speed : 0.7,
		next : undefined,
		item : undefined,
		play : false,
		sound : undefined,
		loop : undefined,
		characters : [spr_port_flour],
		emotions : [0],
		option1 : undefined,
		option2 : undefined,
		auto : false,
		voices : [sfx_talk_flowey],
		colors : [],
		effects : []
	}
];

/// @param dialogue_id
function get_dialogue(_dialogue_id){
	dia = global.dialogues[_dialogue_id];
	return dia;
}

function get_dialogue_csv(_name) {
	var _y = 0;
	ds_table = load_csv("csv_placeholder.csv");
	/*  for multi-language support
	if(lang == "en") {
		curr_ds_table = ds_table_en;
	} else if(lang == "jp") {
	curr_ds_table = ds_table_ja;
	}
	*/

	if (ds_grid_value_exists(ds_table, 0, 0, 0, ds_grid_height(ds_table), _name)) {
   		_y = ds_grid_value_y(ds_table, 0, 0, 0, ds_grid_height(ds_table), _name);
	}
	var _array = [];
	for(var _i = 0; _i < ds_grid_width(ds_table); _i++) {
		_array[_i] = ds_grid_get(ds_table, _i, _y);
	}

	return _array;
}