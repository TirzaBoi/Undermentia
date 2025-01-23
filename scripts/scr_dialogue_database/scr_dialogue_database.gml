function get_dialogue_csv(_name) {
	var _y = 0;
	ds_table = load_csv("en-us.csv");
	/*  for multi-language support
	if(lang == "en") {
		curr_ds_table = ds_table_en;
	} else if(lang == "jp") {
	curr_ds_table = ds_table_ja;
	}
	*/
	
	if(ds_grid_value_exists(ds_table, 0, 0, 0, ds_grid_height(ds_table), _name)) {
		_y = ds_grid_value_y(ds_table, 0, 0, 0, ds_grid_height(ds_table), _name);
	}

	var _text = {
		text: ds_grid_get(ds_table, 1, _y),
		txt_speed: real(ds_grid_get(ds_table, 2, _y)),
		font: asset_get_index(ds_grid_get(ds_table, 3, _y)),
		next: ds_grid_get(ds_table, 4, _y),
		auto: bool(ds_grid_get(ds_table, 5, _y))
	};
	_text.next = _text.next == "undefined" ? undefined : _text.next;

	return _text;
}