/// @description

var _delta = delta_time / 1000000;
var _move_x = keyboard_check(vk_right) - keyboard_check(vk_left);
var _move_y = keyboard_check(vk_down) - keyboard_check(vk_up);

var _new_x = x + (_move_x * movement_speed * _delta);
var _new_y = y + (_move_y * movement_speed * _delta);


// stops player from moving when menu is open
if (global.menu_open) {
	is_moving = false;
	image_index = animation_frames[0];
	return;
} else if(global.in_dialogue or global._isFalling) {
	can_move = false;
} else {
	can_move = true;
}

#region Movement


/* This collision is not ideal at all, but it works well enough for what we need right now.
 * Inefficient, but basic and snappy. We can overhaul it later! */
 
if (can_player_interact) {
	if (!place_meeting(_new_x, y, collision_map) && can_move) x = _new_x;
	if (!place_meeting(x, _new_y, collision_map) && can_move) y = _new_y;
}


if (keyboard_check(vk_tab)) {
	fade_screen(1, #ffffff, 0.5);	
}

// Set Direction & Get Animation
if (_move_x != 0 && can_move) {
	is_moving = true;
	global.dir = (_move_x > 0) ? DIRECTION.RIGHT : DIRECTION.LEFT;
} else if (_move_y != 0 && can_move) {
	is_moving = true;
	global.dir = (_move_y > 0) ? DIRECTION.DOWN : DIRECTION.UP;
} else {
	is_moving = false;
	image_index = animation_frames[0]; // Sets the appropriate idle animation
}

// Set directions animation (changed to make falling work)
if(global.dir == DIRECTION.UP) {
	get_animation("up");
} else if(global.dir == DIRECTION.RIGHT) {
	get_animation("right");
} else if(global.dir == DIRECTION.DOWN) {
	get_animation("down");
} else if(global.dir == DIRECTION.LEFT) {
	get_animation("left");
}

// If falling, fall (wow)
if(global._isFalling) {
	y += 0.000125 * delta_time
	
	if(fallFrame == 5) {
		 if(global.dir == DIRECTION.UP) {
			 global.dir = DIRECTION.RIGHT
		 } else if(global.dir == DIRECTION.RIGHT) {
			 global.dir = DIRECTION.DOWN
		 } else if(global.dir == DIRECTION.DOWN) {
			 global.dir = DIRECTION.LEFT
		 } else if(global.dir == DIRECTION.LEFT) {
		 global.dir = DIRECTION.UP
		 }
		 fallFrame = 0
	 }
	 fallFrame += 1
}

#endregion

#region Interacting
function can_interact() {
	//TODO: Add checking conditions for interacting with objects (is in dialogue, etc...)	
	return !(global.in_dialogue || global.menu_open);
}
var _x_offset = _move_x * collided_length;
var _y_offset = _x_offset != 0 ? 0 : _move_y * collided_length;

if(_x_offset == 0 && _y_offset == 0) {
	_x_offset = last_x_offset;
	_y_offset = last_y_offset;
}

last_x_offset = _x_offset;
last_y_offset = _y_offset;

var _interactable_instance = collision_line(x, y, x + _x_offset, y + _y_offset, obj_trigger_interactable, false, true);
if(can_interact() && _interactable_instance && check_confirm_pressed()) {
	with(_interactable_instance){event_user(0);};
}
#endregion
