#if !defined(USING_MAP_DATUM)

	#include "outpost-01-sub.dmm"
	#include "outpost-02-surface.dmm"
	#include "outpost-03-upper.dmm"
	#include "outpost-04-orbital.dmm"

	#include "outpost_defines.dm"
	#include "outpost_areas.dm"
//	#include "outpost_shuttles.dm"
	#include "outpost_jobs.dm"
	#include "job/outfits.dm"

	#define USING_MAP_DATUM /datum/map/outpost

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Outpost 21

#endif