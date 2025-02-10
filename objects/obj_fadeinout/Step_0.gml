if(phase == 0) {
	image_alpha += fade_speed;
	if(image_alpha >= 1) {
		phase++;
	}
} else {
	image_alpha -= fade_speed;
	if(image_alpha <= 0) {
		instance_destroy();
	}
}