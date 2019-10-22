// NES v1.0
// Copyleft Mojon Twins 2013, 2015, 2017, 2018

// Enems recoiling

#ifdef NEEDS_LIFE_GAUGE_LOGIC
if (en_life [gpit]) 
#endif
{
	#ifdef PLAYER_TOP_DOWN
	if (en_rmx [gpit])
	#endif
	{
		rdx = _en_x; _en_x += en_rmx [gpit];

		cy1 = _en_y >> 4;
		cy2 = (_en_y + 15) >> 4;

		if (en_rmx [gpit] < 0) {
			cx1 = cx2 = _en_x >> 4;
		} else {
			cx1 = cx2 = (_en_x + 15) >> 4;
		}
		cm_two_points ();
		en_collx = at1 | at2;
	
		if (
		#ifdef ENEMS_RECOIL_OVER_BOUNDARIES
			(_en_x == 0 || _en_x >= 240)
		#else
			(
				(_en_x <= _en_x1 || _en_x >= _en_x2)
				#if defined (ENABLE_FANTY) || defined (ENABLE_HOMING_FANTY)				
					&& _en_t != 6
				#endif
				#if defined (ENABLE_PEZONS)
					&& _en_t != 9
				#endif
				#if defined (ENABLE_PURSUERS)
					&& _en_t != 7
				#endif
			)	
		#endif
		#ifdef WALLS_STOP_ENEMIES
			|| en_collx
		#endif
		) _en_x = rdx;
	}

	#ifdef PLAYER_TOP_DOWN
		if (en_rmy [gpit]) {
			rdy = _en_y; _en_y += en_rmy [gpit];
		
			cx1 = _en_x >> 4;
			cy1 = (_en_y + 15) >> 4;

			if (en_rmy [gpit] < 0) {
				cy1 = cy2 = _en_y >> 4;
			} else {
				cy1 = cy2 = (_en_y + 15) >> 4;
			}
			cm_two_points ();
			en_colly = at1 | at2;

			if (
			#ifdef ENEMS_RECOIL_OVER_BOUNDARIES
				(_en_y == 0 || _en_y >= 192)
			#else
				(
					(_en_y <= _en_y1 || _en_y >= _en_y2)
					#if defined (ENABLE_FANTY) || defined (ENABLE_HOMING_FANTY)				
						&& _en_t != 6
					#endif
					#if defined (ENABLE_PEZONS)
						&& _en_t != 9
					#endif
					#if defined (ENABLE_PURSUERS)
						&& _en_t != 7
					#endif
				)
			#endif
			#ifdef WALLS_STOP_ENEMIES
				|| en_colly
			#endif
			) _en_y = rdy;
		}
	#endif
}

#if defined (ENABLE_FANTY) || defined (ENABLE_HOMING_FANTY) || defined (ENABLE_PEZONS)
	if (en_cttouched [gpit] == 0) _enf_x = _en_x << FIXBITS;
#endif
