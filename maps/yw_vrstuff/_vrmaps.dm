#if AWAY_MISSION_TEST
#include "vrmaps.dmm"
#endif

/datum/map_template/common_lateload/vrworld
	name = "VR World"
	desc = "The vr world."
	mappath = 'maps/yw_vrstuff/vrmaps.dmm'
	associated_map_datum = /datum/map_z_level/common_lateload/vrworld_destination

/datum/map_z_level/common_lateload/vrworld_destination
	name = "VR World"
	z = Z_LEVEL_VRWORLD
	flags = MAP_LEVEL_PLAYER|MAP_LEVEL_SEALED
