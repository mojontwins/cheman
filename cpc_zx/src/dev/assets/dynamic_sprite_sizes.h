// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Indexed by MSB:
// 0x00 None
// 0x10 Linear
// 0x20 Platforms
// 0x30 Fanty
// 0x40 Catacrock
// 0x50 not used 
// 0x60 Espectros
// 0x70 Pursuers
// 0x80 these use metatiles
// 0x90 Monococos
// 0xA0 Pezons
// 0xB0 Gyrosaws / Saws

// a 0xff value means "use the LSB arrays".

#ifdef CPC
	const unsigned char dss_msb_ox [] = { 0, 0xff, 0xff, 0, 0, 0, 0, 0xff, 0, 0, 0, 0, 0, 0, 0, 0 };
	const unsigned char dss_msb_oy [] = { 0, 0xff, 0xff, 0, 0, 0, 0, 0xff, 0, 0, 0, 0, 0, 0, 0, 0 };
	const void *dss_msb_invfunc [] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
	const void *dss_msb_updfunc [] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

	// Indexed by LSB (sprite face #)

	const unsigned char dss_lsb_ox [] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
	const unsigned char dss_lsb_oy [] = { -6, -8, -8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
	const void *dss_lsb_invfunc [] = { cpc_PutSpTileMap8x24, cpc_PutSpTileMap8x24, cpc_PutSpTileMap8x24, cpc_PutSpTileMap8x16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
	const void *dss_lsb_updfunc [] = { cpc_PutTrSp8x24TileMap2b, cpc_PutTrSp8x24TileMap2b, cpc_PutTrSp8x24TileMap2b, cpc_PutTrSp8x16TileMap2b, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
#endif
	