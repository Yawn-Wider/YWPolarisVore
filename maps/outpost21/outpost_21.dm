#if !defined(USING_MAP_DATUM)

	#include "outpost-01-subeng.dmm"
	#include "outpost-02-subciv.dmm"
	#include "outpost-03-surfeng.dmm"
	#include "outpost-04-surfciv.dmm"
	#include "outpost-05-upper.dmm"
	#include "outpost-06-orbital.dmm"
	#include "outpost-10-admin.dmm"
	#include "outpost-11-centcom.dmm"

	#include "outpost_defines.dm"
	#include "outpost_areas.dm"
//	#include "outpost_shuttles.dm"
	#include "outpost_jobs.dm"
	#include "job/outfits.dm"

	#define USING_MAP_DATUM /datum/map/outpost

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Outpost 21

#endif