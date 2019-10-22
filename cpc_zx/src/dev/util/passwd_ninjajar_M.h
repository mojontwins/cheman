// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Encodes plife and ptile_get_ctr in a fancy 8 chars password

unsigned char pass [8];

void pass_encode (void) {
	// Break up coins in two nibbles c1 and c2.
	rdb = ptile_get_ctr >> 4;
	rdc = ptile_get_ctr & 15;

	pass [0] = (rand8() & 0xf) + 'A';
	pass [1] = rdb + 'A';
	pass [2] = ((rdb + rdc + plife) & 0xf) + 'A';
	pass [5] = plife + 'A';
	pass [4] = (((plife << 1) - rdc) & 0xf) + 'A';
	pass [3] = rdc + 'A';
	pass [6] = ((rdc - plife + rdb) & 0xf) + 'A';
	pass [7] = pstars + 'A';
} 
