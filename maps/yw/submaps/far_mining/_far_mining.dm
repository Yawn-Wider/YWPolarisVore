/datum/map_template/cryogaia_lateload/far_mining
	name = "Remote Mines - Surface"
	desc = "A long-abandoned mining site."
	mappath = 'far_mining.dmm'
	associated_map_datum = /datum/map_z_level/cryogaia_lateload/far_mining

/datum/map_z_level/cryogaia_lateload/far_mining
	name = "Remote Mines - Surface"
	z = Z_LEVEL_FAR_MINING_SURFACE
	flags = MAP_LEVEL_PLAYER|MAP_LEVEL_SEALED|MAP_LEVEL_CONTACT

/datum/map_template/cryogaia_lateload/far_mining_under
	name = "Remote Mines - Underground"
	desc = "A long-abandoned mining site."
	mappath = 'far_mining_under.dmm'
	associated_map_datum = /datum/map_z_level/cryogaia_lateload/far_mining_under

/datum/map_template/cryogaia_lateload/far_mining_under/on_map_loaded(z)
	. = ..()

	// Now for the tunnels.
	new /datum/random_map/automata/cave_system/no_cracks(null, 3, 3, z, world.maxx - 4, world.maxy - 4)
	new /datum/random_map/noise/ore(null, 1, 1, z, 64, 64)

/datum/map_z_level/cryogaia_lateload/far_mining_under
	name = "Remote Mines - Underground"
	z = Z_LEVEL_FAR_MINING_UNDER
	flags = MAP_LEVEL_PLAYER|MAP_LEVEL_SEALED|MAP_LEVEL_CONTACT


/area/far_mining/refinery
	name = "Distant Mining Site Refinery"

/obj/effect/shuttle_landmark/premade/far_mining
	name = "Distant Mining Site"
	landmark_tag = "far_mining_beacon"
	base_turf = /turf/simulated/floor/outdoors/dirt/cryogaia
	base_area = /area/borealis2/outdoors/grounds

/obj/effect/landmark/map_data/far_mining
	height = 2

/obj/item/weapon/comp_points
	name = "0 Point Ticket"
	var/initial_name = "Point Tickets"
	desc = "It's worth 0 Competition Points."
	gender = PLURAL
	icon = 'icons/obj/economy.dmi'
	icon_state = "spacecash1"
	opacity = 0
	density = FALSE
	anchored = FALSE
	force = 1.0
	throwforce = 1.0
	throw_speed = 1
	throw_range = 2
	w_class = ITEMSIZE_SMALL
	var/access = list()
	access = access_crate_cash
	var/worth = 0
	drop_sound = 'sound/items/drop/paper.ogg'
	pickup_sound = 'sound/items/pickup/paper.ogg'

/obj/item/weapon/comp_points/c100
	name = "100 Point Ticket"
	icon_state = "spacecash10"
	desc = "It's worth 100 Competition Points. Totally worthless outside of the NT Mining Competition."

/obj/item/weapon/comp_points/c1000
	name = "1000 Point Ticket"
	icon_state = "spacecash100"
	desc = "It's worth 1000 Competition Points. Totally worthless outside of the NT Mining Competition."

/obj/item/weapon/comp_points/c10000
	name = "10,000 Point Ticket"
	icon_state = "spacecash200"
	desc = "It's worth 10,000 Competition Points. Totally worthless outside of the NT Mining Competition."

/obj/item/weapon/comp_points/c1000000
	name = "1,000,000 Point Ticket"
	icon_state = "spacecash1000"
	desc = "It's worth 1000 Competition Points. Totally worthless outside of the NT Mining Competition."

/obj/item/weapon/comp_points/mult2
	name = "Multiplier Voucher (x2)"
	icon_state = "spacecash1"
	desc = "Get double the points from all ores! Call Central Command over comms to redeem. Stacks multiplicatively up to 4 times, for a total of 16x point bonus. Totally worthless outside of the NT Mining Competition."

/obj/machinery/mineral/equipment_vendor/far_mining
	name = "old mining equipment vendor"
	desc = "This vendor looks absolutely ancient, and may fall apart at any moment. A small, faded sticker on it proudly states, 'Now with Blue-Space capabilities!!!'"
	icon = 'icons/obj/vending.dmi'
	icon_state = "minevend"
	density = TRUE
	anchored = TRUE
	circuit = /obj/item/weapon/circuitboard/mining_equipment_vendor

/obj/machinery/mineral/equipment_vendor/far_mining/Initialize(mapload)
	. = ..()
	//VOREStation Edit Start - Heavily modified list
	prize_list = list()
	prize_list["Mining Competition"] = list (
		EQUIPMENT("100 Point Ticket", 							/obj/item/weapon/comp_points/c100, 									100),
		EQUIPMENT("1000 Point Ticket", 							/obj/item/weapon/comp_points/c1000, 								1000),
		EQUIPMENT("10,000 Point Ticket", 						/obj/item/weapon/comp_points/c10000, 								10000),
		EQUIPMENT("1,000,000 Point Ticket", 					/obj/item/weapon/comp_points/c1000000, 								1000000),
		EQUIPMENT("Double Points Ticket (Max. 4)", 				/obj/item/weapon/comp_points/mult2, 								500000),
	)
	prize_list["Science Objectives"] = list (
		EQUIPMENT("Circuit Board: Core R&D Console", 					/obj/item/weapon/circuitboard/rdconsole, 							5000),
		EQUIPMENT("Circuit Board: Destructive Analyzer", 				/obj/item/weapon/circuitboard/destructive_analyzer, 				5000),
		EQUIPMENT("Circuit Board: Protolathe", 							/obj/item/weapon/circuitboard/protolathe, 							5000),
		EQUIPMENT("Circuit Board: Exosuit Fabricator", 					/obj/item/weapon/circuitboard/mechfab, 								50000),
		EQUIPMENT("Circuit Board: Parts Lathe", 						/obj/item/weapon/circuitboard/partslathe, 							5000),
		EQUIPMENT("Circuit Board: Prosthetics Fabricator", 				/obj/item/weapon/circuitboard/prosthetics, 							5000),
		EQUIPMENT("Matter Bin", 										/obj/item/weapon/stock_parts/matter_bin, 							100),
		EQUIPMENT("Micro-Manipulator", 									/obj/item/weapon/stock_parts/manipulator, 							100),
		EQUIPMENT("Console Screen", 									/obj/item/weapon/stock_parts/console_screen, 						100),
	)
	prize_list["Engineering Objectives"] = list (
		EQUIPMENT("Rapid Piping Device (RPD)", 						/obj/item/weapon/pipe_dispenser,										500000),
		EQUIPMENT("Circuit Board: Cyborg Recharging Station", 		/obj/item/weapon/circuitboard/recharge_station, 						5000),
		EQUIPMENT("Circuit Board: Mech Recharging Station", 		/obj/item/weapon/circuitboard/mech_recharger, 							5000),
		EQUIPMENT("Circuit Board: Airlock Electronics", 			/obj/item/weapon/airlock_electronics, 									1000),
		EQUIPMENT("Circuit Board: APC Electronics", 				/obj/item/weapon/module/power_control, 									5000),
		EQUIPMENT("Circuit Board: Recharger Electronics", 			/obj/item/weapon/circuitboard/recharger, 								5000),
		EQUIPMENT("Circuit Board: Fax Machine", 					/obj/item/weapon/circuitboard/fax, 										5000),
		EQUIPMENT("Circuit Board: Body Scanner", 					/obj/item/weapon/circuitboard/body_scanner, 							50000),
		EQUIPMENT("Circuit Board: Body Scanner Console", 			/obj/item/weapon/circuitboard/scanner_console, 							5000),
		EQUIPMENT("Circuit Board: Sleeper", 						/obj/item/weapon/circuitboard/sleeper, 									5000),
		EQUIPMENT("Circuit Board: Sleeper Console", 				/obj/item/weapon/circuitboard/sleeper_console, 							5000),
		EQUIPMENT("Cable Coil", 									/obj/item/stack/cable_coil, 											100),
	)
	prize_list["Gear"] = list(
		EQUIPMENT("Defense Equipment - Plasteel Machete",		/obj/item/weapon/material/knife/machete,							1500),
		EQUIPMENT("Hybrid Equipment - Proto-Kinetic Dagger",	/obj/item/weapon/kinetic_crusher/machete/dagger,					1500),
		EQUIPMENT("Hybrid Equipment - Proto-Kinetic Machete",	/obj/item/weapon/kinetic_crusher/machete,							8000),
		EQUIPMENT("GPS Device",									/obj/item/device/gps/mining,										100),
		EQUIPMENT("Survival Equipment - Insulated Poncho",		/obj/random/thermalponcho,											500),
		EQUIPMENT("Mining Satchel of Holding",					/obj/item/weapon/storage/bag/ore/holding,							15000),
		EQUIPMENT("Advanced Ore Scanner",						/obj/item/weapon/mining_scanner/advanced,							5000),
		EQUIPMENT("Graviton Goggles",							/obj/item/clothing/glasses/graviton,								500000),
	)
	prize_list["Medical"] = list(
		EQUIPMENT("Injector (L) - Glucose",	/obj/item/weapon/reagent_containers/hypospray/autoinjector/biginjector/glucose,	500),
		EQUIPMENT("Injector (L) - Panacea",	/obj/item/weapon/reagent_containers/hypospray/autoinjector/biginjector/purity,	500),
		EQUIPMENT("Injector (L) - Trauma",	/obj/item/weapon/reagent_containers/hypospray/autoinjector/biginjector/brute,	500),
		EQUIPMENT("Nanopaste Tube",			/obj/item/stack/nanopaste,														1000),
		EQUIPMENT("Shelter Capsule",		/obj/item/device/survivalcapsule,												500),
		EQUIPMENT("Burn Medipen",			/obj/item/weapon/reagent_containers/hypospray/autoinjector/burn,				250),
		EQUIPMENT("Detox Medipen",			/obj/item/weapon/reagent_containers/hypospray/autoinjector/detox,				250),
		EQUIPMENT("Oxy Medipen",			/obj/item/weapon/reagent_containers/hypospray/autoinjector/oxy,					250),
		EQUIPMENT("Trauma Medipen",			/obj/item/weapon/reagent_containers/hypospray/autoinjector/trauma,				250),
	)
	prize_list["Kinetic Accelerator"] = list(
		EQUIPMENT("Kinetic Accelerator",		/obj/item/weapon/gun/energy/kinetic_accelerator,				9000),
		EQUIPMENT("KA AoE Damage",				/obj/item/borg/upgrade/modkit/aoe/mobs,							20000),
		EQUIPMENT("KA Damage Increase",			/obj/item/borg/upgrade/modkit/damage,							10000),
		EQUIPMENT("KA Cooldown Decrease",		/obj/item/borg/upgrade/modkit/cooldown,							12000),
		EQUIPMENT("KA Range Increase",			/obj/item/borg/upgrade/modkit/range,							10000),
		EQUIPMENT("KA Temperature Modulator",	/obj/item/borg/upgrade/modkit/heater,							10000),
		EQUIPMENT("KA Off-Station Modulator",	/obj/item/borg/upgrade/modkit/offsite, 							17500),
		EQUIPMENT("KA Holster",					/obj/item/clothing/accessory/holster/waist/kinetic_accelerator,	3500),
		EQUIPMENT("KA Super Chassis",			/obj/item/borg/upgrade/modkit/chassis_mod,						2500),
		EQUIPMENT("KA Hyper Chassis",			/obj/item/borg/upgrade/modkit/chassis_mod/orange,				3000),
		EQUIPMENT("KA Adjustable Tracer Rounds",/obj/item/borg/upgrade/modkit/tracer/adjustable,				1750),
		EQUIPMENT("KA White Tracer Rounds",		/obj/item/borg/upgrade/modkit/tracer,							1250),
		EQUIPMENT("Premium Kinetic Accelerator",/obj/item/weapon/gun/energy/kinetic_accelerator/premiumka,		1000000),
	)
	prize_list["Digging Tools"] = list(
		// EQUIPMENT("Diamond Pickaxe",	/obj/item/weapon/pickaxe/diamond,				2000),
		// EQUIPMENT("Kinetic Crusher",	/obj/item/twohanded/required/kinetic_crusher,	750),
		EQUIPMENT("Resonator",			/obj/item/resonator,							900),
		EQUIPMENT("Silver Pickaxe",		/obj/item/weapon/pickaxe/silver,				1200),
		EQUIPMENT("Super Resonator",	/obj/item/resonator/upgraded,					2500),
		EQUIPMENT("Fine Excavation Kit - Chisels",			/obj/item/weapon/storage/excavation,							500),
		EQUIPMENT("Fine Excavation Kit - Measuring Tape",	/obj/item/device/measuring_tape,								125),
		EQUIPMENT("Fine Excavation Kit - Hand Pick",		/obj/item/weapon/pickaxe/hand,									375),
		EQUIPMENT("Explosive Excavation Kit - Plastic Charge",/obj/item/weapon/plastique/seismic/locked,					1500),
		EQUIPMENT("Industrial Equipment - Phoron Bore",		/obj/item/weapon/gun/magnetic/matfed/phoronbore/loaded,			3000),
		EQUIPMENT("Industrial Equipment - Inducer",			/obj/item/weapon/inducer,										3500),
		EQUIPMENT("Industrial Equipment - Sheet-Snatcher",	/obj/item/weapon/storage/bag/sheetsnatcher,						500),
	)
	prize_list["Miscellaneous"] = list(
		EQUIPMENT("Absinthe",					/obj/item/weapon/reagent_containers/food/drinks/bottle/absinthe,	125),
		EQUIPMENT("Cigar",						/obj/item/clothing/mask/smokable/cigarette/cigar/havana,			150),
		EQUIPMENT("Digital Tablet - Standard",	/obj/item/modular_computer/tablet/preset/custom_loadout/standard,	500),
		EQUIPMENT("Laser Pointer",				/obj/item/device/laser_pointer,										900),
		EQUIPMENT("Luxury Shelter Capsule",		/obj/item/device/survivalcapsule/luxury,							3100),
		EQUIPMENT("Bar Shelter Capsule",		/obj/item/device/survivalcapsule/luxurybar,							10000),
		EQUIPMENT("Whiskey",					/obj/item/weapon/reagent_containers/food/drinks/bottle/whiskey,		125),
	)
	prize_list["Extra"] = list() // Used in child vendors
	//VOREStation Edit End
