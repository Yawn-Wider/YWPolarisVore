/turf/simulated/floor/bronze
	name = "bronze floor"
	desc = "Some heavy bronze tiles."
	icon = 'icons/obj/clockwork_objects.dmi'
	icon_state = "clockwork_floor"
//	floor_tile = /obj/item/stack/tile/bronze

	initial_flooring = /decl/flooring/bronze

/turf/simulated/floor/flesh/attackby()
	return

/decl/flooring/bronze
	name = "bronze"
	desc = "Some heavy bronze tiles."
	icon = 'icons/obj/clockwork_objects.dmi'
	icon_base = "clockwork_floor"


/turf/simulated/floor/grass2
	name = "grass patch"
	desc = "You can't tell if this is real grass or just cheap plastic imitation."
	icon ='icons/obj/clockwork_objects.dmi'
	icon_state = "grass"

/decl/flooring/grass2
	name = "grass"
	desc = "You can't tell if this is real grass or just cheap plastic imitation."
	icon ='icons/obj/clockwork_objects.dmi'
	icon_base = "grass"

//Snow

/decl/flooring/snowbrick
	name = "snow brick floor"
	desc = "Flattened snow."
	icon = 'icons/turf/floors_yw.dmi'
	icon_base = "tiles_snowbrick"
	build_type = /obj/item/stack/tile/snowbrick
	damage_temperature = T0C+200
	flags = TURF_HAS_EDGES | TURF_HAS_CORNERS | TURF_REMOVE_CROWBAR
	footstep_sounds = list("human" = list(
		'sound/effects/footstep/floor1.ogg',
		'sound/effects/footstep/floor2.ogg',
		'sound/effects/footstep/floor3.ogg',
		'sound/effects/footstep/floor4.ogg',
		'sound/effects/footstep/floor5.ogg'))
