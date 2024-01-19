/obj/item/clothing/suit/storage/hooded/wintercoat/snowsuit
	name = "snowsuit"
	desc = "A suit made to keep you nice and toasty on cold winter days. Or at least alive."
	icon = 'icons/inventory/suit/item_yw.dmi'
	icon_state = "snowsuit"
	icon_override = 'icons/inventory/suit/mob_yw.dmi'
	item_state = "snowsuit"
	hoodtype =	/obj/item/clothing/head/hood/winter/snowsuit
	allowed = list (/obj/item/weapon/pen, /obj/item/weapon/paper, /obj/item/device/flashlight,/obj/item/weapon/tank/emergency/oxygen, /obj/item/weapon/storage/fancy/cigarettes, /obj/item/weapon/storage/box/matches, /obj/item/weapon/reagent_containers/food/drinks/flask)

/obj/item/clothing/suit/storage/hooded/wintercoat/snowsuit/command
	name = "command snowsuit"
	icon_state = "snowsuit_command"
	item_state = "snowsuit_command"
	hoodtype = /obj/item/clothing/head/hood/winter/snowsuit/command
	armor = list(melee = 20, bullet = 15, laser = 20, energy = 10, bomb = 15, bio = 0, rad = 0)
	allowed =  list (/obj/item/weapon/pen, /obj/item/weapon/paper, /obj/item/device/flashlight,/obj/item/weapon/tank/emergency/oxygen, /obj/item/weapon/storage/fancy/cigarettes,	/obj/item/weapon/storage/box/matches, /obj/item/weapon/reagent_containers/food/drinks/flask, /obj/item/device/suit_cooling_unit, /obj/item/weapon/gun/energy,	/obj/item/weapon/reagent_containers/spray/pepper,/obj/item/weapon/gun/projectile,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/melee/baton, /obj/item/weapon/handcuffs,/obj/item/clothing/head/helmet)

/obj/item/clothing/suit/storage/hooded/wintercoat/snowsuit/security
	name = "security snowsuit"
	icon_state = "snowsuit_security"
	item_state = "snowsuit_security"
	hoodtype = /obj/item/clothing/head/hood/winter/snowsuit/security
	armor = list(melee = 25, bullet = 20, laser = 20, energy = 15, bomb = 20, bio = 0, rad = 0)
	allowed = list (/obj/item/weapon/pen, /obj/item/weapon/paper, /obj/item/device/flashlight,/obj/item/weapon/tank/emergency/oxygen, /obj/item/weapon/storage/fancy/cigarettes, /obj/item/weapon/storage/box/matches, /obj/item/weapon/reagent_containers/food/drinks/flask, /obj/item/device/suit_cooling_unit, /obj/item/weapon/gun/energy,	/obj/item/weapon/reagent_containers/spray/pepper,/obj/item/weapon/gun/projectile,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,	/obj/item/weapon/handcuffs,/obj/item/clothing/head/helmet)

/obj/item/clothing/suit/storage/hooded/wintercoat/snowsuit/medical
	name = "medical snowsuit"
	icon_state = "snowsuit_medical"
	item_state = "snowsuit_medical"
	hoodtype = /obj/item/clothing/head/hood/winter/snowsuit/medical
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 50, rad = 0)
	allowed = list (/obj/item/weapon/pen, /obj/item/weapon/paper, /obj/item/device/flashlight,/obj/item/weapon/tank/emergency/oxygen, /obj/item/weapon/storage/fancy/cigarettes,	/obj/item/weapon/storage/box/matches, /obj/item/weapon/reagent_containers/food/drinks/flask, /obj/item/device/suit_cooling_unit, /obj/item/device/analyzer,/obj/item/stack/medical,	/obj/item/weapon/dnainjector,/obj/item/weapon/reagent_containers/dropper,/obj/item/weapon/reagent_containers/syringe,/obj/item/weapon/reagent_containers/hypospray,	/obj/item/device/healthanalyzer,/obj/item/weapon/reagent_containers/glass/bottle,/obj/item/weapon/reagent_containers/glass/beaker,	/obj/item/weapon/reagent_containers/pill,/obj/item/weapon/storage/pill_bottle)

/obj/item/clothing/suit/storage/hooded/wintercoat/snowsuit/engineering
	name = "engineering snowsuit"
	icon_state = "snowsuit_engineering"
	item_state = "snowsuit_engineering"
	hoodtype = /obj/item/clothing/head/hood/winter/snowsuit/engineering
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 20)
	allowed = list (/obj/item/weapon/pen, /obj/item/weapon/paper, /obj/item/device/flashlight,/obj/item/weapon/tank/emergency/oxygen, /obj/item/weapon/storage/fancy/cigarettes,	/obj/item/weapon/storage/box/matches, /obj/item/weapon/reagent_containers/food/drinks/flask, /obj/item/device/suit_cooling_unit, /obj/item/device/analyzer, /obj/item/device/flashlight,	/obj/item/device/multitool, /obj/item/device/pipe_painter, /obj/item/device/radio, /obj/item/device/t_scanner, /obj/item/weapon/tool/crowbar, /obj/item/weapon/tool/screwdriver,	/obj/item/weapon/weldingtool, /obj/item/weapon/tool/wirecutters, /obj/item/weapon/tool/wrench, /obj/item/weapon/tank/emergency/oxygen, /obj/item/clothing/mask/gas, /obj/item/taperoll/engineering)

/obj/item/clothing/suit/storage/hooded/wintercoat/snowsuit/cargo
	name = "cargo snowsuit"
	icon_state = "snowsuit_cargo"
	item_state = "snowsuit_cargo"
	hoodtype = /obj/item/clothing/head/hood/winter/snowsuit/cargo
	armor = list(melee = 10, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)
	allowed = list (/obj/item/weapon/pen, /obj/item/weapon/paper, /obj/item/device/flashlight, /obj/item/weapon/storage/fancy/cigarettes, /obj/item/weapon/storage/box/matches,	/obj/item/weapon/reagent_containers/food/drinks/flask, /obj/item/device/suit_cooling_unit, /obj/item/weapon/tank, /obj/item/device/radio, /obj/item/weapon/pickaxe, /obj/item/weapon/storage/bag/ore)

/obj/item/clothing/suit/storage/hooded/wintercoat/snowsuit/science
	name = "science snowsuit"
	icon_state = "snowsuit_science"
	item_state = "snowsuit_science"
	hoodtype = /obj/item/clothing/head/hood/winter/snowsuit/science
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 10, bio = 0, rad = 0)
	allowed = list (/obj/item/weapon/pen, /obj/item/weapon/paper, /obj/item/device/flashlight,/obj/item/weapon/tank/emergency/oxygen, /obj/item/weapon/storage/fancy/cigarettes,	/obj/item/weapon/storage/box/matches, /obj/item/weapon/reagent_containers/food/drinks/flask, /obj/item/device/suit_cooling_unit, /obj/item/device/analyzer,/obj/item/stack/medical,	/obj/item/weapon/dnainjector,/obj/item/weapon/reagent_containers/dropper,/obj/item/weapon/reagent_containers/syringe,/obj/item/weapon/reagent_containers/hypospray,	/obj/item/device/healthanalyzer,/obj/item/weapon/reagent_containers/glass/bottle,/obj/item/weapon/reagent_containers/glass/beaker,	/obj/item/weapon/reagent_containers/pill,/obj/item/weapon/storage/pill_bottle)

/obj/item/clothing/suit/storage/hooded/wintercoat/snowsuit/get_worn_icon_file(var/body_type, var/slot_name, var/default_icon, var/inhands)
	if(body_type == SPECIES_TESHARI)
		if(!inhands)
			return 'icons/mob/species/teshari/suit_yw.dmi'
	else
		return ..()
