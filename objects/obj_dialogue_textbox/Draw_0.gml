/// @description Drawing the textbox
x = camera_get_view_x(view_camera[0]) + pos_x;
y = camera_get_view_y(view_camera[0]) + pos_y;

if(!setup) {
	setup = true;
	draw_set_font(font);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	var _last_i = 0;
	var _p = 0;
	var _num_chars = 0;
	for(var _c = 0; _c < text_lenght; _c++) {
		var _char = string_char_at(text, _c + 1);
		if((_char != "/" || string_char_at(text, _c) != "/") && (_char != "/" || string_char_at(text, _c + 2) != "/")) {
			chars[_p, _c - _last_i] = _char;
			_num_chars++;
		} else if(_char == "/" && string_char_at(text, _c) == "/") {
			_last_i = _c + 1;
			text_lenghts[_p] = _num_chars;
			_num_chars = 0;
			_p++;
			num_pages++;
		}
	}
	text_lenghts[_p] = _num_chars;

	for(var _page = 0; _page <= num_pages; _page++) {
		var _string = "";
		for(var _c = 0; _c < text_lenghts[_page]; _c++) {
			_string = string_concat(_string, chars[_page, _c]);
		}
		texts[_page] = _string;
	}
	
	var _delete_stack = [];
	var _total_text_shortage = 0;
	for(var _page = 0; _page <= num_pages; _page++) {
		for(var _c = 0; _c < text_lenghts[_page]; _c++) {
			var _char = string_char_at(texts[_page], _c + 1);
			if(_char == "<") {
				var _end_pos = _c + 1;
				for(var _i = _end_pos; _i < text_lenghts[_page]; _i++) {
					var _ic = string_char_at(texts[_page], _i);
					_end_pos = _i;
					if(_ic == ">") {
						break;
					}
				}
				tag_lenght_stack[array_length(tag_lenght_stack)] = _end_pos - _c;
				var _string_tag = string_copy(texts[_page], _c + 2, _end_pos - _c - 2);
				var _parts = string_split(_string_tag, " ");
				if(string_char_at(_string_tag, 1) == "/") {
					_parts[0] = string_delete(_parts[0], 1, 1);
					var _start_tag = [];
					var _start = 0;
					var _len = 0;
					for(var _i = array_length(tag_stack) - 1; _i >= 0; _i--;) {
						var _tag = tag_stack[_i];
						_start_tag = _tag;
						_start = tag_start_stack[_i];
						_len = tag_lenght_stack[_i];
						if(_tag[0] == _parts[0]) {
							array_delete(tag_stack, _i, 1);
							array_delete(tag_start_stack, _i, 1);
							
							var _real_c = _c;
							for(var _j = 0; _j < array_length(tag_lenght_stack) - 1; _j++) {
								if(_j < _i) {
									_start -= tag_lenght_stack[_j];
								}
								_real_c -= tag_lenght_stack[_j];
							}
							process_tag(_real_c + 1, _page, _start_tag, _start, _len);
							break;
						}
					}
				} else {
					tag_stack[array_length(tag_stack)] = _parts;
					tag_start_stack[array_length(tag_start_stack)] = _c;
				}
				_total_text_shortage += _end_pos - _c;
				_delete_stack[array_length(_delete_stack)] = [_c, _end_pos];
			}
		}
		for(var _x = array_length(tag_stack) - 1; _x >= 0; _x--;) {
			var _start_tag = tag_stack[_x];
			var _start = tag_start_stack[_x];
			var _len = tag_lenght_stack[_x];
			
			array_delete(tag_stack, _x, 1);
			array_delete(tag_start_stack, _x, 1);
							
			var _real_c = _x;
			for(var _j = 0; _j < array_length(tag_lenght_stack) - 1; _j++) {
				if(_j < _x) {
					_start -= tag_lenght_stack[_j];
				}
				_real_c -= tag_lenght_stack[_j];
			}
			process_tag(_real_c + 1, _page, _start_tag, _start, _len);
			break;
		}
		for(var _t = array_length(_delete_stack) - 1; _t >= 0; _t--) {
			array_delete(chars[_page], _delete_stack[_t][0], _delete_stack[_t][1] - _delete_stack[_t][0]);
			texts[_page] = string_delete(texts[_page], _delete_stack[_t][0] + 1, _delete_stack[_t][1] - _delete_stack[_t][0]);
		}
		text_lenghts[_page] -= _total_text_shortage;
		_delete_stack = [];
		_total_text_shortage = 0;
	}
	
	for(var _page = 0; _page <= num_pages; _page++) {
		last_free_space = 0;
		break_nums[_page] = 0;
		break_offset = 0;
		for(var _c = 0; _c < text_lenghts[_page]; _c++) {
			var _txt_w = string_width(string_copy(texts[_page], 1, _c + 1)) - string_width(chars[_page, _c]);
		
			if(chars[_page, _c] == " ") {
				last_free_space = _c + 1;
			}
				
			if(_txt_w - break_offset > background_width - (margin_x * 2) - (characters[_page] != undefined ? 64 + margin_x : 0)) {
				line_breaks[break_nums[_page], _page] = last_free_space;
				break_nums[_page]++;
				break_offset = string_width(string_copy(texts[_page], 1, last_free_space)) - string_width(string_char_at(texts[_page], last_free_space));
			}
		
			color_char[_c, _page] = #ffffff;
			for(var _i = 0; _i < array_length(colors); _i++) {
				if(colors[_i].page == _page) {
					color_char[_c, _page] = colors[_i].start <= _c && colors[_i].end_pos >= _c ? colors[_i].col : color_char[_c, _page];
				}
			}

			effect_char[_c, _page] = [];
			effect_char_params[_c, _page] = [];
			for(var _i = 0; _i < array_length(effects); _i++) {
				if(effects[_i].start <= _c && effects[_i].end_pos >= _c) {
					array_insert(effect_char[_c, _page], array_length(effect_char[_c, _page]), effects[_i].effect);
					array_insert(effect_char_params[_c, _page], array_length(effect_char_params[_c, _page]), effects[_i].params);
				}
			}
		}
	}
	
	for(var _page = 0; _page <= num_pages; _page++) {
		for(var _c = 0; _c < text_lenghts[_page]; _c++) {
			var _txt_x = (background_width / 2) - (characters[page] != undefined ? 64 + margin_x : 0) - margin_x;
			var _txt_y = (background_height / 2) - margin_y;
			
			var _txt_w = string_width(string_copy(texts[_page], 1, _c + 1)) - string_width(chars[_page, _c]);
			var _line = 0;
		
			for(var _b = 0; _b < break_nums[_page]; _b++) {
				if(_c + 1 > line_breaks[_b, _page]) {
					var _copy = string_copy(texts[_page], line_breaks[_b, _page], _c + 1 - line_breaks[_b, _page]);
					_txt_w = string_width(_copy);
					_line = _b + 1;
				}
			}
		
			char_x[_c, _page] = _txt_x - _txt_w;
			char_y[_c, _page] = _txt_y - (line_separation * _line);
		}
	}
}

if(text_index < text_lenghts[page] && txt_timer <= 0) {
	text_index += text_speed;
	text_index = check_return_pressed() ? text_lenghts[page] : text_index;
	text_index = clamp(text_index, 0, text_lenghts[page]);
	
	if(snd_count < snd_delay) {
		snd_count++;
	} else {
		snd_count = 0;
		audio_play_sound(voices[page], 0, false);
	}
	
	var _curr_char = string_char_at(texts[page], text_index + 1);
	
	if(_curr_char == "." || _curr_char == "," || _curr_char == "?" || _curr_char == "!") {
		txt_timer = txt_wait_time;
	}
} else if(text_index < text_lenghts[page] && txt_timer > 0) {
	text_index = check_return_pressed() ? text_lenghts[page] : text_index;
	txt_timer--;
} else if(check_confirm_pressed() || auto) {
	if(page >= num_pages) {
		if(play) {
			//remaking after audio manager
			if(sound != undefined) {
				audio_play_sound(sound, 1, loop);
			} else {
				audio_stop_all();
			}
		}
		if(next == undefined) {
			if(options[0] == undefined) {
				if(object_exists(obj_player)) {
					obj_player.in_dialogue = false;
					obj_player.can_move = true;
				}
				instance_destroy();
			} else {
				text_index = 0;
				setup = false;
				line_breaks = [];
				break_nums = [0];
				break_offset = 0;
				last_free_space = 0;
				chars = [];
				char_x = [];
				char_y = [];
				num_pages = 0;
				page = 0;
				display_dialogue_textbox(options[option].next, self);
			}
		} else {
			text_index = 0;
			setup = false;
			line_breaks = [];
			break_nums = [0];
			break_offset = 0;
			last_free_space = 0;
			chars = [];
			char_x = [];
			char_y = [];
			num_pages = 0;
			page = 0;
			display_dialogue_textbox(next, self);
		}
	} else {
		text_index = 0;
		page++;
	}
}

draw_self();

for(var _c = 0; _c < min(text_index, text_lenghts[page]); _c++) {
	var _c_clamped = min(_c, text_index);
	var _x_offset = (array_contains(effect_char[_c, page], "shake") ? random_range(-1, 1) : 0) * 1.3;
	var _y_offset = (array_contains(effect_char[_c, page], "shake") ? random_range(-1, 1) : 0) * 1.3;
	var _color = color_char[_c, page];
	draw_text_color(x - char_x[_c_clamped, page] + _x_offset, y - char_y[_c_clamped, page] + _y_offset, chars[page, _c_clamped], _color, _color, _color, _color, 1);
}

if(characters[page] != undefined) {
	draw_sprite(characters[page], emotions[page], x - (background_width / 2) + margin_x, y - (background_height / 2) + margin_y);
}

if(options[0] != undefined && text_index == text_lenghts[page] && page >= num_pages) {
	var _col0 = option == 0 ? c_yellow : c_white;
	var _col1 = option == 1 ? c_yellow : c_white;
	var _x_soul_offset = option == 0 ? 0 : (background_width / 2) + 20;
	draw_text_ext_color(x - (background_width / 2) + margin_x + (characters[page] != undefined ? 64 + margin_x : 0) + 50, y + (background_height / 2) - margin_y - 20, options[0].text, line_separation, background_width - (margin_x * 2) - (characters[page] != undefined ? 64 : 0), _col0, _col0, _col0, _col0, 1);	
	draw_text_ext_color(x + margin_x + (characters[page] != undefined ? 64 + margin_x : 0) + 70, y + (background_height / 2) - margin_y - 20, options[1].text, line_separation, background_width - (margin_x * 2) - (characters[page] != undefined ? 64 : 0), _col1, _col1, _col1, _col1, 1);
	draw_sprite_stretched(spr_soul, 1, x - (background_width / 2) + (characters[page] != undefined ? 64 : 0) + 40 + _x_soul_offset,  y + (background_height / 2) - margin_y - 25, 20, 23);
}