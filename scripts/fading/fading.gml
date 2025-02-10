function fade_in(_duration, _color, _x, _y){
	var _inc = 1 / _duration;
	var _instance = instance_create_layer(_x, _y, layer_get_id("VFX"), obj_fadein);
	_instance.image_blend = _color;
	_instance.fade_speed = _inc;
}
function fade_out(_duration, _color, _x, _y){
	var _inc = 1 / _duration;
	var _instance = instance_create_layer(_x, _y, layer_get_id("VFX"), obj_fadeout);
	_instance.image_blend = _color;
	_instance.fade_speed = _inc;
}
function fade_inout(_duration, _color, _x, _y){
	var _inc = 1 / (_duration / 2);
	var _instance = instance_create_layer(_x, _y, layer_get_id("VFX"), obj_fadeinout);
	_instance.image_blend = _color;
	_instance.fade_speed = _inc;
}