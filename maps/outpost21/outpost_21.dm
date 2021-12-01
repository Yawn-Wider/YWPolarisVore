#if !defined(USING_MAP_DATUM)

	#include "sl340-1.dmm"
	#include "sl340-2.dmm"
//	#include "polaris-3.dmm"
//	#include "polaris-4.dmm"
//	#include "polaris-5.dmm"

	#include "outpost_defines.dm"
	#include "outpost_areas.dm"
//	#include "outpost_shuttles.dm"
	#include "outpost_jobs.dm"
	#include "job/outfits.dm"

	#define USING_MAP_DATUM /datum/map/outpost

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Outpost 21

#endif