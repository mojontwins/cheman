
#define _CPCRSLIB_H

extern void __FASTCALL__            cpc_PutSp (void);
extern void  __FASTCALL__ __LIB__   cpc_ShowTileMap(int x);
extern void  __FASTCALL__ __LIB__   cpc_ShowScrTileMap(int x);
extern void  __FASTCALL__ __LIB__   cpc_ShowScrTileMap2(int x);
extern void  __FASTCALL__ __LIB__   cpc_UpdScrAddresses(unsigned int x);
extern void  __LIB__   				cpc_TouchTileXY(unsigned char x, unsigned char y);
extern void  __LIB__   				cpc_TouchTileSpXY(unsigned char x, unsigned char y);
extern void  __CALLEE__ __LIB__ 	cpc_ResetTouchedTiles(void);
extern void  __CALLEE__ __LIB__		cpc_UpdScr(void);
extern void  __CALLEE__ __LIB__ 	cpc_ShowTouchedTiles2(void);
extern void  __CALLEE__ __LIB__ 	cpc_ShowTouchedTiles(void);
extern void  __FASTCALL__ __LIB__   cpc_PutSpTileMap(int sprite);
extern void  __FASTCALL__ __LIB__   cpc_PutSpTileMap4x8(int sprite);
extern void  __FASTCALL__ __LIB__   cpc_PutSpTileMap8x16(int sprite);
extern void  __FASTCALL__ __LIB__   cpc_PutSpTileMap8x24(int sprite);
extern void  __FASTCALL__ __LIB__   cpc_PutSpTileMapO(int sprite);
extern void  __FASTCALL__ __LIB__   cpc_PutMaskSpTileMap2b(int sprite);
extern void  __FASTCALL__ __LIB__   cpc_PutTrSpTileMap2b(int sprite);
extern void  __FASTCALL__ __LIB__   cpc_PutORSpTileMap2b(int sprite);
extern void  __FASTCALL__ __LIB__   cpc_PutSpTileMap2b(int sprite);
extern void  __FASTCALL__ __LIB__   cpc_PutCpSpTileMap2b(int sprite);
extern void  __FASTCALL__ __LIB__   cpc_PutMaskSpriteTileMap2b(int sprite);
extern void  __FASTCALL__ __LIB__   cpc_PutTrSpriteTileMap2b(int sprite);
extern void  __FASTCALL__ __LIB__   cpc_PutTrSp4x8TileMap2b(int sprite);
extern void  __FASTCALL__ __LIB__   cpc_PutTrSp8x16TileMap2b(int sprite);
extern void  __FASTCALL__ __LIB__   cpc_PutTrSp8x24TileMap2b(int sprite);
extern void  __FASTCALL__ __LIB__   cpc_SuperbufferAddress(int sprite);
extern void  __FASTCALL__ __LIB__   cpc_UpdateTileMap(int spritelist);
extern void  __LIB__   				cpc_SpUpdX(int sprite, char x);
extern void  __LIB__   				cpc_SpUpdY(int sprite, char y);
extern unsigned char  __LIB__   	cpc_CollSp(int sprite1, int sprite2);
extern void  __LIB__  				cpc_SetTile(unsigned char x, unsigned char y, unsigned char byte);
extern void  __LIB__   				cpc_SetTouchTileXY(unsigned char x, unsigned char y, unsigned char byte);
extern unsigned char  __LIB__   	cpc_ReadTile(unsigned char x, unsigned char y);
extern void  __LIB__   				cpc_PutSp(int *sprite, char *alto, char *ancho, int *posicion);
extern void  __LIB__   				cpc_PutSpXOR(int *sprite, char *alto, char *ancho, int *posicion);
extern void  __CALLEE__ __LIB__  	cpc_PutSpriteXOR(int *sprite, int *posicion);
extern void  __CALLEE__ __LIB__  	cpc_PutMaskSprite(int *sprite, int *posicion);
extern void  __CALLEE__ __LIB__  	cpc_PutSprite(int *sprite, int *posicion);
extern void  __LIB__   				cpc_PutMaskSp(int *sprite, char *alto, char *ancho, int *posicion);
extern void  __LIB__   				cpc_PutSpTr(int *sprite, char *alto, char *ancho, int *posicion);
extern void  __LIB__   				cpc_PutMaskSp2x8(int *sprite, int *posicion);
extern void  __LIB__   				cpc_PutMaskSp4x16(int *sprite, int *posicion);
extern void  __LIB__   				cpc_PutTile2x8(int *tile, char *x, char *y);
extern void  __LIB__   				cpc_PutTile4x16(int *tile, char *x, char *y);
extern void  __FASTCALL__ __LIB__   cpc_SpRLM1(int sprite);
extern void  __FASTCALL__ __LIB__   cpc_SpRRM1(int sprite);
extern void  __LIB__   				cpc_SetInk(unsigned char pos, unsigned char color);
extern void  __LIB__   				cpc_SetColour(unsigned char pos, unsigned char color);
extern void  __FASTCALL__ __LIB__   cpc_SetBorder(unsigned char color);
extern void  __FASTCALL__ __LIB__   cpc_SetMode(unsigned char color);
extern void  __FASTCALL__ __LIB__   cpc_SetModo(unsigned char x);
extern char  __FASTCALL__ __LIB__   cpc_TestKey(unsigned char tecla);	
extern char  __CALLEE__ __LIB__ 	cpc_AnyKeyPressed(void);	
extern void  __FASTCALL__ __LIB__   cpc_RedefineKey(unsigned char tecla);
extern void  __LIB__   				cpc_AssignKey(unsigned char tecla, int valor);
extern void  __CALLEE__ __LIB__   	cpc_DeleteKeys(void);
extern void  __FASTCALL__ __LIB__   cpc_PrintStr(int *cadena);
extern int   __LIB__   				cpc_GetScrAddress(char *x, char *y);
extern void  __CALLEE__ __LIB__   	cpc_Uncrunch(int *origen, int *destino);
extern void  __CALLEE__ __LIB__   	cpc_UnExo(int *origen, int *destino);
extern void  __LIB__   				cpc_GetSp(int *sprite, char *alto, char *ancho, int *posicion);
extern void  __LIB__   				cpc_PrintGphStr(int *cadena, int *destino);
extern void  __LIB__   				cpc_PrintGphStr2X(int *cadena, int *destino);
extern void  __LIB__   				cpc_PrintGphStrXY(int *cadena, char *x, char *y);
extern void  __LIB__   				cpc_PrintGphStrXY2X(int *cadena, char *x, char *y);
extern void  __LIB__   				cpc_PrintGphStrM1(int *cadena, int *destino);
extern void  __LIB__   				cpc_PrintGphStrXYM1(int *cadena, char *x, char *y);
extern void  __LIB__   				cpc_PrintGphStrM12X(int *cadena, int *destino);
extern void  __LIB__   				cpc_PrintGphStrXYM12X(int *cadena, char *x, char *y);
extern void  __LIB__   				cpc_PrintGphStrStd(int *cadena, int *destino);
extern void  __LIB__   				cpc_PrintGphStrStdXY(int *cadena, char *x, char *y);
extern void  __LIB__   				cpc_SetInkGphStr(char *color, char *valor);
extern void  __LIB__   				cpc_SetInkGphStrM1(char *color, char *valor);
extern void  __FASTCALL__ __LIB__   cpc_InitTileMap(int tiles);
extern char  __CALLEE__ __LIB__   	cpc_ScrollLeft0(void);
extern char  __CALLEE__ __LIB__   	cpc_ScrollRight0(void);
extern void  __LIB__   				cpc_GetTiles(unsigned char x, unsigned char y, unsigned char w, unsigned char h, unsigned int buffer);
extern void  __LIB__   				cpc_PutTiles(unsigned char x, unsigned char y, unsigned char w, unsigned char h, unsigned int buffer);
extern void  __LIB__   				cpc_TouchTiles(unsigned char x, unsigned char y, unsigned char w, unsigned char h);
extern void  __LIB__   				cpc_RRI(unsigned int pos, unsigned char w, unsigned char h);
extern void  __LIB__   				cpc_RLI(unsigned int pos, unsigned char w, unsigned char h);
extern void  __CALLEE__ __LIB__   	cpc_DisableFirmware(void);
extern void  __CALLEE__ __LIB__   	cpc_EnableFirmware(void);
extern void  __CALLEE__ __LIB__   	cpc_ClrScr(void);
extern void  __CALLEE__ __LIB__   	cpc_ScanKeyboard(void);
extern char  __FASTCALL__ __LIB__   cpc_TestKeyF(unsigned char tecla);	
