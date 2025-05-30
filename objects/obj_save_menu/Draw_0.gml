/// @description Draw menu

// Background
draw_sprite_ext(sprite_index, image_index, top_left_corner[0], top_left_corner[1], width/sprite_width, height/sprite_height, 0, c_white, 1)

// Options
draw_set_font(fnt_undertale)
draw_set_valign(fa_middle)
draw_set_halign(fa_center)

var _default_color = has_saved ? c_yellow : c_white
var _scene_text = has_saved ? "File saved" : full_room_name

draw_text_color(top_left_corner[0] + padding_x, top_left_corner[1] + padding_y , player_name, _default_color, _default_color, _default_color, _default_color, 1) // Link properly with better save format
draw_text_color(bottom_right_corner[0] - padding_x, top_left_corner[1] + padding_y , obj_globalmanager.format_seconds(ds_map_find_value(global.player_data, "time")), _default_color, _default_color, _default_color, _default_color, 1) // Link properly with better save format

draw_text_color(x, y - 4, _scene_text, _default_color, _default_color, _default_color, _default_color, 1)

var _colors = [c_white, c_white]

for (var _i = 0; _i < op_length; _i++) {
	if (_i == pos) {
	  _colors[_i] = c_yellow
	}
}

draw_text_color(top_left_corner[0] + padding_x_options, bottom_right_corner[1] - padding_y_options, option[0], _colors[0], _colors[0], _colors[0], _colors[0], 1)
draw_text_color(bottom_right_corner[0] - padding_x_options, bottom_right_corner[1] - padding_y_options, option[1], _colors[1],  _colors[1],  _colors[1],  _colors[1], 1) // Added 40 for save width