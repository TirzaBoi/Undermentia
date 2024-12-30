/// @description

// delta time is not needed since this isn't computationally expensive and should always run at full speed
//var _delta = delta_time / 1000000;

var _move_x = keyboard_check(vk_right) - keyboard_check(vk_left);
var _move_y = keyboard_check(vk_down) - keyboard_check(vk_up);

//var _new_x = x + (_move_x * movement_speed * _delta);
//var _new_y = y + (_move_y * movement_speed * _delta);
var _delta_x = _move_x * movement_speed;
var _delta_y = _move_y * movement_speed;

// stops player from moving when menu is open
if (global.menu_open) {
	is_moving = false;
	return;
}

#region Movement

if (can_player_interact) {
	x+=_delta_x;
	if(place_meeting(x,y,obj_col)){
		x=round(x); // just in case anyone adds back delta
		while(place_meeting(x,y,obj_col)){
			x-=sign(_delta_x);
		}
	}else{
		if(place_meeting(x,y,obj_slope)){
			if(!place_meeting(x,y-ceil(movement_speed),obj_slope)){
				y-=ceil(movement_speed);
			}else if(!place_meeting(x,y+ceil(movement_speed),obj_slope)){
				y+=ceil(movement_speed);
			}
		}
	}
	
	y+=_delta_y;
	if(place_meeting(x,y,obj_col)){
		y=round(y); // just in case anyone adds back delta
		while(place_meeting(x,y,obj_col)){
			y-=sign(_delta_y);
		}
	}else{
		if(place_meeting(x,y,obj_slope)){
			if(!place_meeting(x-ceil(movement_speed),y,obj_slope)){
				x-=ceil(movement_speed);
			}else if(!place_meeting(x+ceil(movement_speed),y,obj_slope)){
				x+=ceil(movement_speed);
			}
		}
	}
	
}

if (keyboard_check(vk_tab)) {
	fade_screen(1, #ffffff, 0.5);	
}

// Set Direction & Get Animation
if (_move_x != 0) {
	is_moving = true;
	dir = (_move_x > 0) ? DIRECTION.RIGHT : DIRECTION.LEFT;
	get_animation((_move_x > 0) ? "right" : "left");
} else if (_move_y != 0) {
	is_moving = true;
	dir = (_move_y > 0) ? DIRECTION.DOWN : DIRECTION.UP;
	get_animation((_move_y > 0) ? "down" : "up");
} else {
	is_moving = false;
	image_index = animation_frames[0]; // Sets the appropriate idle animation
}

#endregion
