// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// ----------------------------------------------------------
// System 
// ----------------------------------------------------------
#ifdef SPECCY
	struct sp_UDK keys;
	void *joyfunc;
	int key_jump;

	struct sp_Rect spritesClipValues = { 
		SCR_Y + 1,
		SCR_X, 
		22,
		32
	};

	struct sp_Rect ensClipRects [N_ENEMS];

	struct sp_Rect *spritesClip;
	struct sp_Rect fsRect = {0, 0, 24, 32};


	struct sp_SS *sp_sw [SW_SPRITES_ALL];
	unsigned char *spr_next [SW_SPRITES_ALL];
	unsigned char *spr_cur [SW_SPRITES_ALL];

	#ifdef SE_BEEPER
		unsigned char queued_sound;
	#endif

	signed char sp_sw_coy [SW_SPRITES_ALL], sp_sw_cox [SW_SPRITES_ALL];
	#define SP_SW_COY (sp_sw_coy [gpit])
	#define SP_SW_COX (sp_sw_cox [gpit])

	unsigned char dynamic_memory_pool [1+15*NUMBLOCKS];
#endif

#ifdef CPC
	#define KEY_LEFT 		0
	#define KEY_RIGHT		1
	#define KEY_DOWN 		2
	#define KEY_UP  		3
	#define KEY_BUTTON_A	4
	#define KEY_BUTTON_B	5
	#define KEY_ENTER		6
	#define KEY_ESC			7
	#define KEY_AUX1		8
	#define KEY_AUX2		9
	
	typedef struct sprite {
		int sp0;					// 0
		int sp1; 					// 2
		int coord0;
		signed char cox, coy;		// 6 7
		unsigned char cx, cy; 		// 8 9
		unsigned char ox, oy;		// 10 11
		void *invfunc;				// 12
		void *updfunc;				// 14
	} SPR;

	unsigned char *spr_next [SW_SPRITES_ALL];

	//SPR sp_sw [SW_SPRITES_ALL];
	SPR sp_sw [SW_SPRITES_ALL] @ BASE_SPRITES;
	#define SP_SW_COY (sp_sw [gpit].coy)
	#define SP_SW_COX (sp_sw [gpit].cox)

	unsigned char spr_order [SW_SPRITES_ALL];
#endif

unsigned char spr_idx;
unsigned char spr_on [SW_SPRITES_ALL];
unsigned char spr_x [SW_SPRITES_ALL], spr_y [SW_SPRITES_ALL];

// ----------------------------------------------------------
// General 
// ----------------------------------------------------------
unsigned char gpit, gpjt;
unsigned int gpint;
signed char rds;
signed int rdsint;
unsigned char rda, rdb, rdc, rdd, rde, rdf, rdi;
unsigned char rdx, rdy, rdt, rdct, rdxx, rdyy, rdyx, rdch;
unsigned char *gp_gen, *gp_aux;
unsigned char *gp_int;
unsigned char pad0, pad, pad_this_frame;
unsigned char ticker;
unsigned char _x, _y, _n, _t, _d1, _d2;
unsigned char __x, __y, __d;

// ----------------------------------------------------------
// Collision 
// ----------------------------------------------------------
unsigned char cx1, cx2, cy1, cy2, at1, at2, t1, t2;

// ----------------------------------------------------------
// Current level, screen, etc
// ----------------------------------------------------------
unsigned char level, olevel;
unsigned char *c_level;
unsigned char c_level_map_w;
unsigned char n_pant, on_pant;
unsigned char half_life, flip_flop, frame_counter, hl_proc;
unsigned char do_game, first_time;

// ----------------------------------------------------------
// Map stuff
// ----------------------------------------------------------
unsigned char *gp_map;

#ifdef SPECCY
	unsigned char scr_buff [SCR_BUFFER_SIZE] @ FREEPOOL;
	#ifdef MODE_128K
		unsigned char scr_attr [SCR_BUFFER_SIZE];
	#else
		unsigned char scr_attr [SCR_BUFFER_SIZE] @ (FREEPOOL + SCR_BUFFER_SIZE);
	#endif	
#endif
#ifdef CPC
	// Stuff this in gaps in VRAM
	// unsigned char scr_attr [SCR_BUFFER_SIZE];
	// unsigned char scr_buff [SCR_BUFFER_SIZE];
	unsigned char scr_attr [SCR_BUFFER_SIZE] @ FREEPOOL;
	unsigned char scr_buff [SCR_BUFFER_SIZE] @ (FREEPOOL + SCR_BUFFER_SIZE);
#endif

// ----------------------------------------------------------
// Player
// ----------------------------------------------------------
#ifdef ENEMIES_CAN_DIE
unsigned char pbodycount, opbodycount;
#endif
unsigned char plife, oplife, pobjs, opobjs, pkeys, opkeys;
unsigned char pstars, opstars;
#ifdef AMMO_MAX
unsigned char pammo, opammo;
#endif
unsigned char evil_tile_hit;
unsigned char pkilled;
unsigned char pemmeralds;
unsigned char pinv;
unsigned char guay_ct, use_ct, no_ct;

unsigned char prx, pry;
signed int px, py;
#if PLAYER_VX_MAX > 127
	#define PVX_INT
	signed int pvx;
#else
	signed char pvx;
#endif
#if PLAYER_VY_MAX > 127
	#define PVY_INT
	signed int pvy;
	#ifdef PLAYER_MONONO
		signed int pvylast;
	#endif
#else
	signed char pvy;
	#ifdef PLAYER_MONONO
		signed char pvylast;
	#endif
#endif

#ifdef PLAYER_JUMPS
	unsigned char pj, pctj, pthrust, pjb;
	unsigned char pjustjumped;
#endif

#ifdef PLAYER_DOUBLE_JUMP
	unsigned char njumps;
#endif

#ifdef PLAYER_BUTT
	unsigned char pbutt;
#endif

#ifdef PLAYER_PUSH_BOXES_ANIMATE
	unsigned char ppushing;
#endif

unsigned char pfiring;
unsigned char phit, pflickering;
unsigned char pstep, pframe, pfacing, pgotten, ppossee, pregotten;
unsigned char pfixct;
unsigned char psprid; 
signed char pgtmx, pgtmy;
unsigned char pcharacter;

#ifdef PLAYER_SPINS
	unsigned char pspin;
#endif	

#ifdef PLAYER_GENITAL
	unsigned char pfacingh, pfacingv, pfacinglast;
#endif

#if defined (EVIL_TILE_MULTI) || defined (EVIL_TILE_CENTER) || defined (PLAYER_DIE_AND_RESPAWN)
	signed int pcx, pcy;
#endif

#ifdef PLAYER_SAFE
	unsigned char safe_prx, safe_pry;
	unsigned char safe_n_pant;
#endif

#ifdef SHOOTING_DRAINS
	unsigned char pgauge;
#endif

unsigned char pwashit;
unsigned char pstatespradder;

#ifdef PLAYER_HIDES
	unsigned char phidden;
#endif

#ifdef ENABLE_HOLES
	unsigned char pholed;
#endif

#ifdef ENABLE_SLIPPERY
	unsigned char pslips;
#endif

#ifdef ENABLE_WATER
	unsigned char pwater;
	unsigned char pwaterthrustct;
#endif

#ifdef PLAYER_PUSH_BOXES
	unsigned char pbx1, pby1;
#endif

#ifdef ENABLE_TILE_GET
	unsigned char ptile_get_ctr, optile_get_ctr;
	#ifdef PERSISTENT_TILE_GET
		#ifdef SPECCY
			unsigned char tile_got [MAX_PANTS*12];
		#endif
		#ifdef CPC
			unsigned char tile_got [MAX_PANTS*12] @ (TEXTBUFF + 0x200 - (MAX_PANTS*12));
		#endif
		unsigned char tile_got_offset;
	#endif		
#endif	

// ----------------------------------------------------------
// Enemies
// ----------------------------------------------------------
unsigned char _en_t, _en_x, _en_y;
unsigned char _en_x1, _en_x2, _en_y1, _en_y2;
signed char _en_mx, _en_my;
unsigned char _en_state, _en_ct;

#ifdef ENEMS_UPSIDE_DOWN
	unsigned char _en_ud;
#endif

#ifdef SPECCY
	unsigned char en_hl [N_ENEMS];
	unsigned char en_life [N_ENEMS];
	unsigned char en_s [N_ENEMS];
	unsigned char en_facing [N_ENEMS];
	unsigned char en_dying [N_ENEMS]; 
	unsigned char en_washit [N_ENEMS];

	#ifdef ENABLE_TYPE_7
		unsigned char en_fishing [N_ENEMS];
		unsigned char en_v [N_ENEMS];
	#endif

	#ifdef TYPE7_WITH_GENERATOR
		unsigned char en_gen_washit [N_ENEMS];
		unsigned char en_gen_dying [N_ENEMS];
		unsigned char en_gen_life [N_ENEMS];
	#endif

	#ifdef ENEMIES_NEED_FP
		#if defined (ENABLE_FANTY) || defined (ENABLE_ESPECTROS) || defined (ENABLE_PRECALC_TIMED_FANTY)
		unsigned char fanty_timer [N_ENEMS];
		signed int enf_x [N_ENEMS];
		signed char enf_vx [N_ENEMS];
		signed int _enf_x;
		signed char _enf_vx;
		#endif
		signed int enf_y [N_ENEMS];
		signed char enf_vy [N_ENEMS];
		signed int _enf_y;
		signed char _enf_vy;
	#endif

	unsigned char en_t [N_ENEMS];
	unsigned char en_x [N_ENEMS];
	unsigned char en_y [N_ENEMS];
	unsigned char en_x1 [N_ENEMS];
	unsigned char en_y1 [N_ENEMS];
	unsigned char en_x2 [N_ENEMS];
	unsigned char en_y2 [N_ENEMS];
	signed char en_mx [N_ENEMS];
	signed char en_my [N_ENEMS];

	unsigned char en_state [N_ENEMS];
	unsigned char en_ct [N_ENEMS];
#endif

#ifdef CPC
	extern unsigned char en_hl [N_ENEMS] @ (BASE_EN);
	extern unsigned char en_life [N_ENEMS] @ (BASE_EN + N_ENEMS);
	extern unsigned char en_s [N_ENEMS] @ (BASE_EN + 2*N_ENEMS);
	extern unsigned char en_facing [N_ENEMS] @ (BASE_EN + 3*N_ENEMS);
	extern unsigned char en_dying [N_ENEMS] @ (BASE_EN + 4*N_ENEMS);
	extern unsigned char en_washit [N_ENEMS] @ (BASE_EN + 5*N_ENEMS);
	extern unsigned char en_fishing [N_ENEMS] @ (BASE_EN + 6*N_ENEMS);
	extern unsigned char en_v [N_ENEMS] @ (BASE_EN + 7*N_ENEMS);
	extern unsigned char en_gen_washit [N_ENEMS] @ (BASE_EN + 8*N_ENEMS);
	extern unsigned char en_gen_dying [N_ENEMS] @ (BASE_EN + 9*N_ENEMS);
	extern unsigned char en_gen_life [N_ENEMS] @ (BASE_EN + 10*N_ENEMS);
	extern unsigned char *fanty_timer @ (BASE_EN + 11*N_ENEMS);
	extern signed int *enf_x @ (BASE_EN + 12*N_ENEMS);
	extern signed char *enf_vx @ (BASE_EN + 14*N_ENEMS);
	extern signed int _enf_x;
	extern signed char _enf_vx;
	extern signed int *enf_y @ (BASE_EN + 15*N_ENEMS);
	extern signed char *enf_vy @ (BASE_EN + 17*N_ENEMS);
	extern signed int _enf_y;
	extern signed char _enf_vy;
	extern unsigned char en_t [N_ENEMS] @ (BASE_EN + 18*N_ENEMS);
	extern unsigned char en_x [N_ENEMS] @ (BASE_EN + 19*N_ENEMS);
	extern unsigned char en_y [N_ENEMS] @ (BASE_EN + 20*N_ENEMS);
	extern unsigned char en_x1 [N_ENEMS] @ (BASE_EN + 21*N_ENEMS);
	extern unsigned char en_y1 [N_ENEMS] @ (BASE_EN + 22*N_ENEMS);
	extern unsigned char en_x2 [N_ENEMS] @ (BASE_EN + 23*N_ENEMS);
	extern unsigned char en_y2 [N_ENEMS] @ (BASE_EN + 24*N_ENEMS);
	extern signed char en_mx [N_ENEMS] @ (BASE_EN + 25*N_ENEMS);
	extern signed char en_my [N_ENEMS] @ (BASE_EN + 26*N_ENEMS);
	extern unsigned char en_state [N_ENEMS] @ (BASE_EN + 27*N_ENEMS);
	extern unsigned char en_ct [N_ENEMS] @ (BASE_EN + 28*N_ENEMS);
#endif

#ifdef PERSISTENT_ENEMIES

#ifdef SPECCY
	unsigned char ep_x [3*MAX_PANTS] @ BASE_EP;
	unsigned char ep_y [3*MAX_PANTS] @ (BASE_EP + 3*MAX_PANTS);
	signed char ep_mx [3*MAX_PANTS] @ (BASE_EP + 2*3*MAX_PANTS);
	signed char ep_my [3*MAX_PANTS] @ (BASE_EP + 3*3*MAX_PANTS);
	unsigned int ep_it;
#endif

#ifdef CPC
	unsigned char ep_x [3*MAX_PANTS] @ BASE_EP;
	unsigned char ep_y [3*MAX_PANTS] @ (BASE_EP + 3*MAX_PANTS);
	#ifdef PERSISTENT_ENEMIES_PACKED
		unsigned char ep_myx [3*MAX_PANTS] @ (BASE_EP + 2*3*MAX_PANTS);
	#else
		signed char ep_mx [3*MAX_PANTS] @ (BASE_EP + 2*3*MAX_PANTS);
		signed char ep_my [3*MAX_PANTS] @ (BASE_EP + 3*3*MAX_PANTS);
	#endif
	unsigned int ep_it;
#endif
	
#endif

#if defined(ENEMIES_CAN_DIE) && defined(PERSISTENT_DEATHS)	
	#ifdef SPECCY
		unsigned char ep_killed [MAX_PANTS * N_ENEMS];
	#endif
	#ifdef CPC
		// unsigned char *ep_killed = BASE_EP + 4*3*MAX_PANTS;
		unsigned char ep_killed [MAX_PANTS * N_ENEMS] @ (BASE_EP + 4*3*MAX_PANTS);
	#endif
#endif

#ifdef ENEMS_UPSIDE_DOWN
	unsigned char en_ud [N_ENEMS];
#endif

unsigned char spr_id, en_fr;
unsigned char enoffs;
unsigned char genflipflop;
unsigned char is_platform;
unsigned char encelloffset;

#ifdef LINEAR_COLLIDES
	unsigned char en_collx, en_colly;
#endif

// ----------------------------------------------------------
// Hitter
// ----------------------------------------------------------
unsigned char hitter_hs_x;
unsigned char hitter_hs_y;
unsigned char hitter_x, hitter_y, hitter_frame;

// ----------------------------------------------------------
// Breakable walls
// ----------------------------------------------------------
#ifdef BREAKABLE_WALLS
	#ifdef SPECCY
		#if defined (MODE_128K)
			unsigned char brk_ac [BREAKABLE_MAX];
			unsigned char brk_slots [BREAKABLE_MAX];
			unsigned char brk_x [BREAKABLE_MAX];
			unsigned char  brk_y [BREAKABLE_MAX];
		unsigned char brk_slot;
	#else
			unsigned char brk_ac [BREAKABLE_MAX] @ BASE_BREAKABLE;
			unsigned char brk_slots [BREAKABLE_MAX] @ (BASE_BREAKABLE + BREAKABLE_MAX);
			unsigned char brk_x [BREAKABLE_MAX] @ (BASE_BREAKABLE + 2*BREAKABLE_MAX);
			unsigned char brk_y [BREAKABLE_MAX] @ (BASE_BREAKABLE + 3*BREAKABLE_MAX);
		unsigned char brk_slot;
	#endif
#ifdef BREAKABLE_TILE_SPECIAL
			#if defined (MODE_128K)
		unsigned char brk_sp [BREAKABLE_MAX];	
	#else	
				unsigned char brk_sp [BREAKABLE_MAX] @ (BASE_BREAKABLE + 4*BREAKABLE_MAX);
			#endif	
		#endif
	#endif
	#ifdef CPC
		// Stuff this in gaps in VRAM
		unsigned char brk_slot;
		unsigned char brk_ac [BREAKABLE_MAX] @ BASE_BREAKABLE;
		unsigned char brk_slots [BREAKABLE_MAX] @ (BASE_BREAKABLE + BREAKABLE_MAX);
		unsigned char brk_x [BREAKABLE_MAX] @ (BASE_BREAKABLE + 2*BREAKABLE_MAX);
		unsigned char brk_y [BREAKABLE_MAX] @ (BASE_BREAKABLE + 3*BREAKABLE_MAX);
		unsigned char brk_sp [BREAKABLE_MAX] @ (BASE_BREAKABLE + 4*BREAKABLE_MAX);
#endif
	unsigned char process_breakable;
#endif

// ----------------------------------------------------------
// Floating boxes
// ----------------------------------------------------------

#ifdef FLOATY_PUSH_BOXES
	#ifndef BREAKABLE_MAX
		#define BREAKABLE_MAX 0
	#endif
	#define BASE_FLOATY (BASE_BREAKABLE + 5*BREAKABLE_MAX)
	unsigned char fpb_slot;
	unsigned char fpb_ac [FPB_MAX] @ BASE_FLOATY;
	unsigned char fpb_slots [FPB_MAX] @ (BASE_FLOATY + FPB_MAX);
	unsigned char fpb_yx [FPB_MAX] @ (BASE_FLOATY + 2*FPB_MAX);
	unsigned char fpb_ct [FPB_MAX] @ (BASE_FLOATY + 3*FPB_MAX);

	unsigned char process_floaty;
#endif

// ----------------------------------------------------------
// Hotspots
// ----------------------------------------------------------
#ifndef DEACTIVATE_HOTSPOTS
	unsigned char hrx, hry, hrt;
	unsigned char max_hotspots_type_1;
	#ifdef HOTSPOTS_MAY_CHANGE
		unsigned char ht [MAX_PANTS];
	#endif
	#ifdef SPECCY
		unsigned char hact [MAX_PANTS];
	#endif
	#ifdef CPC
		unsigned char hact [MAX_PANTS] @ (BASE_EN + 29*N_ENEMS);
	#endif
#endif

// ----------------------------------------------------------
// Locks
// ----------------------------------------------------------
#ifdef HOTSPOT_TYPE_KEY
	unsigned char lkact [BOLTS_MAX];
#endif	

// ----------------------------------------------------------
// Cocos
// ----------------------------------------------------------
#ifdef ENABLE_COCOS
	signed int _coco_x, _coco_y;
	unsigned char coco_it;
	unsigned char coco_slot;
	#ifdef SPECCY
		signed int coco_x [COCOS_MAX], coco_y [COCOS_MAX];
		signed int coco_vx [COCOS_MAX], coco_vy [COCOS_MAX];
		unsigned char coco_slots [COCOS_MAX];
	#endif
	#ifdef CPC
		#define COCO_BASE (BASE_EN + 29*N_ENEMS) + MAX_PANTS
		signed int coco_x [COCOS_MAX]  @ COCO_BASE;
		signed int coco_y [COCOS_MAX]  @ COCO_BASE + 2*COCOS_MAX;
		signed int coco_vx [COCOS_MAX] @ COCO_BASE + 4*COCOS_MAX;
		signed int coco_vy [COCOS_MAX] @ COCO_BASE + 6*COCOS_MAX;
		unsigned char coco_slots [COCOS_MAX] @ COCO_BASE + 8*COCOS_MAX;
	#endif
#endif

// ----------------------------------------------------------
// Bullets
// ----------------------------------------------------------
#ifdef PLAYER_CAN_FIRE
	unsigned char b_slot, bic, bi;
	unsigned char _b_x, _b_y;
	signed char _b_mx, _b_my;
	#ifdef SPECCY
		unsigned char b_x [BULLETS_MAX], b_y [BULLETS_MAX];
		signed char b_mx [BULLETS_MAX], b_my [BULLETS_MAX];
		unsigned char b_ac [BULLETS_MAX];
		unsigned char b_slots [BULLETS_MAX];
	#else
		#ifdef ENABLE_COCOS
			#define BULLETS_BASE COCO_BASE + 9*COCOS_MAX;
		#else
			#define BULLETS_BASE (BASE_EN + 29*N_ENEMS) + MAX_PANTS
		#endif
		unsigned char b_x  [BULLETS_MAX]  @ BULLETS_BASE;
		unsigned char b_y  [BULLETS_MAX]  @ BULLETS_BASE + BULLETS_MAX;
		signed char   b_mx [BULLETS_MAX]  @ BULLETS_BASE + 2*BULLETS_MAX;
		signed char   b_my [BULLETS_MAX]  @ BULLETS_BASE + 3*BULLETS_MAX;
		unsigned char b_ac [BULLETS_MAX]  @ BULLETS_BASE + 4*BULLETS_MAX;
		unsigned char b_slots [BULLETS_MAX] @ BULLETS_BASE + 5*BULLETS_MAX;
	#endif
#endif

// ----------------------------------------------------------
// Special features
// ----------------------------------------------------------
#ifdef ENABLE_SPRINGS
	unsigned char springs_on;
#endif

// ----------------------------------------------------------
// ISR
// ----------------------------------------------------------
#ifdef SPECCY
unsigned char isrc;
#endif

#ifdef CPC
	unsigned char isrc, isrc_max;
	unsigned char arkc;
#endif

// ----------------------------------------------------------
// Timed message
// ----------------------------------------------------------
unsigned char tm_ctr;

// ----------------------------------------------------------
// Scripting
// ----------------------------------------------------------
#ifdef SCRIPTING_ON
	unsigned char sc_n, sc_c;
	const unsigned char *next_script;
	const unsigned char *script;
	unsigned char script_result, sc_terminado, sc_continuar;
	unsigned char commands_executed;
	#ifdef ENABLE_FIRE_ZONE
		unsigned char fzx1, fzy1, fzx2, fzy2, f_zone_ac;
	#endif
	unsigned char *scripts_index;
	#ifdef ACTION_KEY_DOWN
		unsigned char down_debounce;
	#endif
#endif
#ifdef SPECCY
	unsigned char flags [MAX_FLAGS];
#endif
#ifdef CPC
	unsigned char flags [MAX_FLAGS] @ 0xCFFF-MAX_FLAGS;
#endif

// ----------------------------------------------------------
// Custom
// ----------------------------------------------------------

unsigned char pnude;			// equals 0 or 20
unsigned char objs_taken [12];	// remember which
unsigned char objs_taken_i;		// index to that.

