// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Spaghetti

#ifdef SE_BEEPER
void beep_fx (unsigned char n);
#endif

void hotspots_load (void);

#ifdef SCRIPTING_ON
void game_run_fire_script (void);
#endif

#ifdef CPC
void cpc_show_updated (void);
void p_s (unsigned char *s);
#endif

void p_t2 (void);

void _pal_set (unsigned char *s);
