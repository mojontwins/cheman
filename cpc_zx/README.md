# Cheman - CPC / ZX version

Cheman for Amstrad CPC and Sinclair ZX Spectrum is built using `MTE MK3_OM v0.6`. 

## How to build

To build this version, use the included `z88dk10_cpcrslib_splib2.7z` package included in this repository:

1. Unpack to `c:\`.
2. Open a console.
3. Navigate to the `cpc_zx/src/dev` folder in this repository and run `setenv.bat`
4. Run `compile_cpc.bat` or `compile_zx.bat`

### compile_cpc.bat parameters

You can run `compile_cpc.bat [target]` where `[target]` can be `tape` (to build a .cdt file) or `disk` (to build a .dsk file). Running `compile_cpc.bat` with no parameters produces a .sna file.
