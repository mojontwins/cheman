// NES MK1 v1.0
// Copyleft Mojon Twins 2013, 2015, 2017, 2018

// Pause?
if (pad_this_frame & PAD_START) {
	paused ^= 1;
	pal_bright (4 - paused);
	music_pause (paused);
}
