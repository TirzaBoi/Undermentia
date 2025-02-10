/// @description Automatically displays the story
if(image_index < frame_count) {
	fade_inout(70, c_black, x, y);
	alarm_set(1, 30);
}