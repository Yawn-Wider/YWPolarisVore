/obj/item/clothing/head/hood/winter/snowsuit
	name = "hood"
	desc = "A generic hood."
	icon = 'icons/inventory/head/item_yw.dmi'
	icon_state = "hood"
	icon_override = 'icons/inventory/head/mob_yw.dmi'
	item_state = "hood"

/obj/item/clothing/head/hood/winter/snowsuit/command
	name = "colony director's winter hood"
	armor = list(melee = 20, bullet = 15, laser = 20, energy = 10, bomb = 15, bio = 0, rad = 0)
	icon_state = "commandhood"
	item_state = "commandhood"
/obj/item/clothing/head/hood/winter/snowsuit/security
	name = "security winter hood"
	armor = list(melee = 25, bullet = 20, laser = 20, energy = 15, bomb = 20, bio = 0, rad = 0)
	icon_state = "sechood"
	item_state = "sechood"
/obj/item/clothing/head/hood/winter/snowsuit/medical
	name = "medical winter hood"
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 50, rad = 0)
	icon_state = "medihood"
	item_state = "medihood"
/obj/item/clothing/head/hood/winter/snowsuit/science
	name = "science winter hood"
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 10, bio = 0, rad = 0)
	icon_state = "scihood"
	item_state = "scihood"
/obj/item/clothing/head/hood/winter/snowsuit/engineering
	name = "engineering winter hood"
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 20)
	icon_state = "engihood"
	item_state = "engihood"
/obj/item/clothing/head/hood/winter/snowsuit/cargo
	name = "cargo winter hood"
	armor = list(melee = 10, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)
	icon_state = "cargohood"
	item_state = "cargohood"

/obj/item/clothing/head/hood/winter/snowsuit/get_worn_icon_file(var/body_type, var/slot_name, var/default_icon, var/inhands)
	if(body_type == SPECIES_TESHARI)
		if(!inhands)
			return 'icons/mob/species/teshari/suit_yw.dmi'
	else
		return ..()
