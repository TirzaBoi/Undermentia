/// @param dialogue_id
/// @description Creates a new instance of a dialogue box
function display_dialogue(_id, _caller_instance) {
	if(is_string(_id)) {
		dialogue = get_dialogue_csv(_id);
	} else {
		dialogue = _id;
	}
	instance = instance_create_depth(0, 0, -9998, obj_dialogue_textbox);
	instance.text = dialogue.text;
	instance.text_speed = dialogue.txt_speed;
	instance.font[0, 0] = dialogue.font;
	instance.next = dialogue.next;
	instance.text_lenght = string_length(dialogue.text);
	instance.auto = dialogue.auto;
	instance.caller = _caller_instance;
}

/// @param dialogue textbox_instance
/// @description Adds a new dialogue into an existing dialogue box
function display_dialogue_textbox(_num, _textbox, _caller_instance) {
	if(is_string(_num)) {
		dialogue = get_dialogue_csv(_num);
	} else {
		dialogue = _num;
	}
	_textbox.text = dialogue.text;
	_textbox.text_speed = dialogue.txt_speed;
	_textbox.font[0, 0] = dialogue.font;
	_textbox.next = dialogue.next;
	_textbox.text_lenght = string_length(dialogue.text);
	_textbox.auto = dialogue.auto;
	_textbox.caller = _caller_instance;
}

/// @param dialogue 
/// @description Creates a new instance of a dialogue box with your dialogue
function display_dialogue_custom(_id, _caller_instance) {
	if(is_string(_id)) {
		dialogue = get_dialogue_csv(_id);
	} else {
		dialogue = _id;
	}
	instance = instance_create_depth(0, 0, -9998, obj_dialogue_textbox);
	instance.text = dialogue.text;
	instance.text_speed = dialogue.txt_speed;
	instance.font[0, 0] = dialogue.font;
	instance.next = dialogue.next;
	instance.text_lenght = string_length(dialogue.text);
	instance.auto = dialogue.auto;
	instance.caller = _caller_instance;
}

/// @param dialogue textbox_instance
/// @description Adds your dialogue into an existing dialogue box
function display_dialogue_textbox_custom(_num, _textbox, _caller_instance) {
	if(is_string(_num)) {
		dialogue = get_dialogue_csv(_num);
	} else {
		dialogue = _num;
	}
	_textbox.text = dialogue.text;
	_textbox.text_speed = dialogue.txt_speed;
	_textbox.font[0, 0] = dialogue.font;
	_textbox.next = dialogue.next;
	_textbox.text_lenght = string_length(dialogue.text);
	_textbox.auto = dialogue.auto;
	_textbox.caller = _caller_instance;
}