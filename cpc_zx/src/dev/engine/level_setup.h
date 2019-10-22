// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Level decompressor

// There's only one level, so this isn't needed. Most of it.

void level_setup (void) {
	// Decompress current level to the heap
	// Costomize as needed. See assets/levelset.h

	c_level = levels [level];

	// Make coding simpler
	c_level_map_w = c_level [LEVEL_MAP_W];
	
	// For this game, decompress map, locks, enemies and hotspots
	librarian_get_resource (c_level [RES_MAP], map);
	librarian_get_resource (c_level [RES_LOCKS], locks);
	librarian_get_resource (c_level [RES_ENEMS], enems);
	librarian_get_resource (c_level [RES_HOTSPOTS], hotspots);

	// Also tileset patterns, metatileset and behs
	librarian_get_resource (c_level [RES_BEHS], behs);
	librarian_get_resource (c_level [RES_TS], ts0);
	librarian_get_resource (c_level [RES_META], tsmaps);
	
#ifdef SCRIPTING_ON
	//scripts_index = scripts + level_script_offsets [*gp_gen];
	scripts_index = scripts;
#endif
	// Now you can use c_level as an array (pointed to the current level array)
}
