// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Precalculated stuff

#if defined (SHOOTING_DRAINS) || defined (ENEMS_UPSIDE_DOWN)
	const unsigned char jitter [] = { 0,1,1,0,0,1,0,1,1,0,0,0,1,0,1,1 };
#endif

#ifdef PLAYER_CAN_FIRE
	// RIGHT LEFT DOWN UP
	const signed char bu_dx [] = {8, -8, 0, 0};
	const signed char bu_dy [] = {0, 0, 8, -8};
	const signed char boffsx [] = {12, -4, 0, 0};
	const signed char boffsy [] = {3, 3, 12, -4};
#endif

#ifdef ENABLE_COCO_STRAIGHT
	// LEFT UP RIGHT DOWN
	const signed char coco_vx_precalc [] = { -COCO_V, 0, COCO_V, 0 };
	const signed char coco_vy_precalc [] = { 0, -COCO_V, 0, COCO_V };
#endif

#ifdef ENABLE_MONOCOCO
	const unsigned char monococo_state_times [] = {
		MONOCOCO_BASE_TIME_HIDDEN, MONOCOCO_BASE_TIME_APPEARING, MONOCOCO_BASE_TIME_ONBOARD, MONOCOCO_BASE_TIME_APPEARING
	};
#endif 

const signed char jitter_big [] = {
	-1, -1, -1, -4, 4, -3, 0, -4, -2, 3, -3, 2, 1, -1, 0, -2
};

#if defined (ENABLE_PRECALC_FANTY) || defined (ENABLE_PRECALC_HOMING_FANTY) || defined (ENABLE_PRECALC_TIMED_FANTY)
	#define FANTY_INCS_MAX 16
	const signed char fanty_incs [] = {
		// Slower fanty
		// 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 1, 1
		// Faster fanty
		// 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1
		// Much faster fanty
		0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 2, 1, 2, 2, 2, 2
	};
#endif

#ifdef ENABLE_PRECALC_HOMING_FANTY
	#define FANTY_RETREAT_INCS_MAX 4
	const signed char fanty_retreat_incs [] = {
		1, 0, 0, 0
	};
#endif

#ifdef ENABLE_PRECALC_PEZON
	#define PEZON_INCS_MAX 48
	#define PEZON_INCS_FIRST_FALL 26
	const signed char pezon_incs [] = {
		-6, -6, -5, -5, -5, -4, -4, -4,
		-4, -4, -3, -3, -3, -2, -2, -2, 
		-2, -2, -1, -1, -1, 0, 0, 0, 
		0, 0, 1, 1, 1, 2, 2, 2, 
		2, 2, 3, 3, 3, 4, 4, 4, 
		4, 4, 4, 4, 4, 4, 4, 4
	};
#endif

#ifdef ENABLE_FABOLEES
	#define FBL_INCR_MAX_X 59
	const unsigned char fbl_incr_x [] = {
		0x02, 0x03, 0x02, 0x03, 0x02, 0x02, 0x03, 0x02, 0x02, 0x02, 0x03, 0x02, 0x02, 0x02, 0x02, 0x02, 
		0x02, 0x02, 0x02, 0x01, 0x02, 0x02, 0x01, 0x02, 0x02, 0x01, 0x02, 0x01, 0x02, 0x01, 0x01, 0x02, 
		0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x01, 0x01, 
		0x00, 0x01, 0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x00 //, 0x00, 0x00, 0x00, 0x00
	};

	#define FBL_INCR_MAX_Y 53
	const unsigned char fbl_incr_y [] = {
		0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x01, 0x00, 0x00, 
		0x01, 0x01, 0x00, 0x01, 0x00, 0x01, 0x01, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x01, 
		0x01, 0x02, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x02, 0x01, 0x01, 0x02, 0x01, 0x02, 0x01, 0x01, 
		0x02, 0x02, 0x01, 0x02, 0x01, 0x02 //, 0x02, 0x01, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x01, 0x02
	};
#endif

const unsigned char bitmask [] = {
	1, 2, 4, 8, 16, 32, 64, 128
};

#ifdef PLAYER_PUNCHES
const unsigned char hitter_offs [] = {0, 8, 10, 12, 12, 8};
#endif
