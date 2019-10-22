// MTEZX MK3
// Copyleft 2017 by The Mojon Twins

// librarian

void librarian_get_resource (unsigned char rn, unsigned char *dst) {
	if (rn)
	#ifndef USE_EXOMIZER
		unpack (library [rn], dst);
	#else
		cpc_UnExo ((int *)(library [rn]), (int *)(dst));
	#endif
}

