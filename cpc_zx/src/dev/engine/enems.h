// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Enems

void enems_restore_vals (void) {
	#asm
		ld  de, (_gpit)
		ld  d, 0

		ld  hl, _en_x
		add hl, de 
		ld  a, (__en_x)
		ld  (hl), a

		ld  hl, _en_y
		add hl, de 
		ld  a, (__en_y)
		ld  (hl), a

		ld  hl, _en_mx
		add hl, de 
		ld  a, (__en_mx)
		ld  (hl), a

		ld  hl, _en_my
		add hl, de 
		ld  a, (__en_my)
		ld  (hl), a

		ld  hl, _en_ct
		add hl, de 
		ld  a, (__en_ct)
		ld  (hl), a

		ld  hl, _en_state
		add hl, de 
		ld  a, (__en_state)
		ld  (hl), a

		ld  hl, _en_x1
		add hl, de 
		ld  a, (__en_x1)
		ld  (hl), a

		ld  hl, _en_y1
		add hl, de 
		ld  a, (__en_y1)
		ld  (hl), a

		ld  hl, _en_x2
		add hl, de 
		ld  a, (__en_x2)
		ld  (hl), a

		ld  hl, _en_y2
		add hl, de 
		ld  a, (__en_y2)
		ld  (hl), a

		#ifdef ENEMS_UPSIDE_DOWN
			ld  hl, _en_ud
			add hl, de 
			ld  a, (__en_ud)
			ld  (hl), a
		#endif
	#endasm

	// TODO: Translate this
	#ifdef ENEMIES_NEED_FP
		enf_x [gpit] = _enf_x; enf_y [gpit] = _enf_y;
		enf_vx [gpit] = _enf_vx; enf_vy [gpit] = _enf_vy;
	#endif				
}

#ifdef PERSISTENT_ENEMIES
	void persistent_enems_load (void) {
	#ifdef ENEMS_FORMAT_UNPACKED
		gp_gen = enems;
		for (ep_it = 0; ep_it < 3 * MAX_PANTS; ep_it ++) {
			// Skip t
			gp_gen ++;

			// YX1
			rda = *gp_gen ++;
			ep_y [ep_it] = rda & 0xf0;
			ep_x [ep_it] = (rda << 4);

			// YX2
			rda = *gp_gen ++;
			rdc = rda & 0xf0;
			rdb = rda << 4;

			// P, here used for speed
			rda = *gp_gen ++;
			
			#ifdef PERSISTENT_ENEMIES_PACKED
				rds = ADD_SIGN2 (rdb, ep_x [ep_it], rda);
				if (rds >= 0) rdd = rds; else rdd = 0x08 | (-rds);

				rds = ADD_SIGN2 (rdc, ep_y [ep_it], rda);
				if (rds >= 0) rdd |= (rds << 4); else rdd |= ((0x08 | (-rds)) << 4);

				ep_myx [ep_it] = rdd;
			#else
				ep_mx [ep_it] = ADD_SIGN2 (rdb, ep_x [ep_it], rda);
				ep_my [ep_it] = ADD_SIGN2 (rdc, ep_y [ep_it], rda);		
			#endif
		}
	#else
		gpit = MAX_PANTS; while (gpit --) {
			ep_it = gpit + gpit + gpit; //gpit + (gpit << 1);

			// Find address
			rdc = gpit << 1;
			rda = *(enems + rdc); rdb = *(enems + rdc + 1);
			if ((rda | rdb) != 0) {
				gp_gen = (unsigned char *) (enems + ((rdb << 8) | rda));

				gpjt = 3; while (gpjt --) {
					rdt = *gp_gen ++;
					if (!rdt) break;

					// YX1
					rda = *gp_gen ++;
					ep_y [ep_it] = rda & 0xf0;
					ep_x [ep_it] = (rda << 4);

					// YX2
					rda = *gp_gen ++;
					rdc = rda & 0xf0;
					rdb = rda << 4;

					// P, here used for speed
					rda = *gp_gen ++;

					#ifdef PERSISTENT_ENEMIES_PACKED
						rds = ADD_SIGN2 (rdb, ep_x [ep_it], rda);
						if (rds >= 0) rdd = rds; else rdd = 0x08 | (-rds);

						rds = ADD_SIGN2 (rdc, ep_y [ep_it], rda);
						if (rds >= 0) rdd |= (rds << 4); else rdd |= ((0x08 | (-rds)) << 4);

						ep_myx [ep_it] = rdd;
					#else
						ep_mx [ep_it] = ADD_SIGN2 (rdb, ep_x [ep_it], rda);
						ep_my [ep_it] = ADD_SIGN2 (rdc, ep_y [ep_it], rda);
					#endif

					ep_it ++;
				}
			}	
		}
	#endif
	}

	void persistent_update (void) {
		for (gpit = 0; gpit < 3; gpit ++) {
			ep_x [enoffs] = en_x [gpit];
			ep_y [enoffs] = en_y [gpit];
			#ifdef PERSISTENT_ENEMIES_PACKED
				if (en_mx [gpit] >= 0) rdb = en_mx [gpit]; else rdb = (-en_mx [gpit]) | 0x08;
				if (en_my [gpit] >= 0) rdb |= (en_my [gpit] << 4); else rdb |= (((-en_my [gpit]) << 4) | 0x80);
				ep_myx [enoffs] = rdb;
			#else
				ep_mx [enoffs] = en_mx [gpit];
				ep_my [enoffs] = en_my [gpit];	
			#endif
			enoffs ++;		
		}	
	}
#endif

#if defined(ENEMIES_CAN_DIE) && defined(PERSISTENT_DEATHS)
	void enems_persistent_deaths_init (void) {
		gpit = MAX_PANTS * N_ENEMS; while (gpit) { --gpit; ep_killed [gpit] = 0; }
	}
#endif

#include "engine/enemmods/enems_load_assembly.h"

#ifdef ENEMIES_CAN_DIE
	#include "engine/enemmods/enems_drain_assembly.h"
#endif

#ifdef ENABLE_TYPE7
	#ifdef TYPE7_WITH_GENERATOR
		void enems_draw_generator (void) {
			// TODO
			/*
			// Add generator
			if (genflipflop) oam_index = oam_meta_spr (
				en_x1 [gpit], en_y1 [gpit] + SPRITE_ADJUST, 
				oam_index, 
				spr_enems [TYPE7_BASE_SPRITE + !!en_gen_washit [gpit]]);
			*/
			//genflipflop = 1 - genflipflop;
		}
	#endif
#endif

#include "engine/enemmods/enems_do_assembly.h"
