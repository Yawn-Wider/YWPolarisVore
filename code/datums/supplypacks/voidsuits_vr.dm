/datum/supply_pack/voidsuits/explorer
	name = "Exploration voidsuits" // YW EDIT
	contains = list(
			/obj/item/clothing/suit/space/void/exploration = 2,
			/obj/item/clothing/head/helmet/space/void/exploration = 2,
			/obj/item/clothing/mask/breath = 2,
			/obj/item/clothing/shoes/magboots = 2,
			/obj/item/weapon/tank/oxygen = 2
			)
	cost = 45
	containertype = /obj/structure/closet/crate/secure
	containername = "Exploration voidsuit crate" // YW EDIT
	access = access_explorer // YW EDIT

/datum/supply_pack/voidsuits/explorer_medic
	name = "Expedition Medic voidsuits" // YW EDIT
	contains = list(
			/obj/item/clothing/suit/space/void/exploration = 2,
			/obj/item/clothing/head/helmet/space/void/exploration = 2,
			/obj/item/clothing/mask/breath = 2,
			/obj/item/clothing/shoes/magboots = 2,
			/obj/item/weapon/tank/oxygen = 2
			)
	cost = 45
	containertype = /obj/structure/closet/crate/secure
	containername = "Expedition Medic voidsuit crate" // YW EDIT
	access = access_explorer // YW EDIT

/datum/supply_pack/voidsuits/pilot
	name = "Pilot voidsuits"
	contains = list(
			/obj/item/clothing/suit/space/void/pilot = 1,
			/obj/item/clothing/head/helmet/space/void/pilot = 1,
			/obj/item/clothing/mask/breath = 1,
			/obj/item/clothing/shoes/magboots = 1,
			/obj/item/weapon/tank/oxygen = 1
			)
	cost = 20
	containertype = /obj/structure/closet/crate/secure
	containername = "Pilot voidsuit crate"
	access = access_pilot


// Surplus!
/datum/supply_pack/voidsuits/com_mining
	name = "SolGov mining voidsuit" //YW EDIT
	contains = list(
		/obj/item/clothing/suit/space/void/mining/alt2,
		/obj/item/clothing/head/helmet/space/void/mining/alt2
	)
	cost = 150
	containertype = /obj/structure/closet/crate/secure
	name = "SolGov mining voidsuit crate" //YW EDIT
	access = access_mining

/datum/supply_pack/voidsuits/com_anomaly
	name = "SolGov anomaly suit" //YW EDIT
	contains = list(
		/obj/item/clothing/suit/space/anomaly/alt,
		/obj/item/clothing/head/helmet/space/anomaly/alt
	)
	cost = 150
	containertype = /obj/structure/closet/crate/secure
	name = "SolGov anomaly suit crate" //YW EDIT
	access = access_xenoarch

/datum/supply_pack/voidsuits/com_riot
	name = "SolGov riot voidsuit" //YW EDIT
	contains = list(
		/obj/item/clothing/suit/space/void/security/riot/alt,
		/obj/item/clothing/head/helmet/space/void/security/riot/alt
	)
	cost = 150
	containertype = /obj/structure/closet/crate/secure
	name = "SolGov riot voidsuit crate" //YW EDIT
	access = access_brig

/datum/supply_pack/voidsuits/com_pilot
	name = "SolGov pilot voidsuit" //YW EDIT
	contains = list(
		/obj/item/clothing/suit/space/void/pilot/alt2,
		/obj/item/clothing/head/helmet/space/void/pilot/alt2
	)
	cost = 150
	containertype = /obj/structure/closet/crate/secure
	name = "SolGov pilot voidsuit crate" //YW EDIT
	access = access_pilot

/datum/supply_pack/voidsuits/com_medical
	name = "SolGov medical voidsuit" //YW EDIT
	contains = list(
		/obj/item/clothing/suit/space/void/medical/alt2,
		/obj/item/clothing/head/helmet/space/void/medical/alt2
	)
	cost = 150
	containertype = /obj/structure/closet/crate/secure
	name = "SolGov medical voidsuit crate" //YW EDIT

/datum/supply_pack/voidsuits/com_explore
	name = "SolGov exploration voidsuit" //YW EDIT
	contains = list(
		/obj/item/clothing/suit/space/void/exploration/alt2,
		/obj/item/clothing/head/helmet/space/void/exploration/alt2
	)
	cost = 150
	containertype = /obj/structure/closet/crate/secure
	name = "SolGov exploration voidsuit crate" //YW EDIT
	access = list(access_eva, access_explorer) //YW EDIT

/datum/supply_pack/voidsuits/com_engineer
	name = "SolGov engineering voidsuit" //YW EDIT
	contains = list(
		/obj/item/clothing/suit/space/void/engineering/alt2,
		/obj/item/clothing/head/helmet/space/void/engineering/alt2
	)
	cost = 150
	containertype = /obj/structure/closet/crate/secure
	name = "SolGov engineering voidsuit crate" //YW EDIT
	access = access_engine

/datum/supply_pack/voidsuits/com_atmos
	name = "SolGov atmos voidsuit" //YW EDIT
	contains = list(
		/obj/item/clothing/suit/space/void/atmos/alt2,
		/obj/item/clothing/head/helmet/space/void/atmos/alt2
	)
	cost = 150
	containertype = /obj/structure/closet/crate/secure
	name = "SolGov atmos voidsuit crate" //YW EDIT
	access = access_atmospherics

/datum/supply_pack/voidsuits/com_captain
	name = "SolGov captain voidsuit" //YW EDIT
	contains = list(
		/obj/item/clothing/suit/space/void/captain/alt,
		/obj/item/clothing/head/helmet/space/void/captain/alt
	)
	cost = 150
	containertype = /obj/structure/closet/crate/secure
	name = "SolGov captain voidsuit crate" //YW EDIT
	access = access_captain

/datum/supply_pack/voidsuits/csc_breaker
	name = "Shipbreaker's Industrial Suit (inc. jetpack)"
	contains = list(
		/obj/item/clothing/suit/space/void/salvagecorp_shipbreaker,
		/obj/item/clothing/head/helmet/space/void/salvagecorp_shipbreaker,
		/obj/item/weapon/tank/jetpack/breaker
	)
	cost = 100
	containertype = /obj/structure/closet/crate/secure
	name = "Coyote Salvage Corp industrial voidsuit crate"
