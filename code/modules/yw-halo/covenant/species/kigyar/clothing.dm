#define KIGYAR_CLOTHING_PATH 'code/modules/yw-halo/covenant/species/kigyar/jackalclothing.dmi'

/obj/item/clothing/head/helmet/kigyar
	name = "Kig-Yar Scout Helmet"
	desc = "A Kig-Yar scout helmet with inbuilt night vision."
	icon = KIGYAR_CLOTHING_PATH
	icon_state = "scouthelm_obj"
	item_state = "scouthelm"
	sprite_sheets = list(SPECIES_KIGYAR_YW = KIGYAR_CLOTHING_PATH,SPECIES_TVAOAN_KIGYAR_YW = 'code/modules/yw-halo/covenant/species/tvoan/skirm_clothing.dmi')
	armor = list(melee = 50, bullet = 55, laser = 40,energy = 40, bomb = 20, bio = 0, rad = 0)
	species_restricted = list(SPECIES_KIGYAR_YW)
	flags_inv = null
	matter = list("nanolaminate" = 1)

/obj/item/clothing/head/helmet/kigyar/major
	name = "Kig-Yar Major Scout Helmet"
	icon_state = "scouthelm_obj_major"
	item_state = "scouthelm_major"

/obj/item/clothing/under/kigyar/noarmor
	name = "Kig-Yar Bodysuit (unarmored)"
	desc = "A Kig-Yar body suit for Ruuhtians and T\'vaoans. Meant to be worn underneath a combat harness - This one is made of simple cloth and has no armor"
	armor =  list(melee = 0, bullet = 0, laser = 0, energy = 10, bomb = 0, bio = 0, rad = 0)
/obj/item/clothing/under/kigyar
	name = "Kig-Yar Bodysuit"
	desc = "A Kig-Yar body suit for Ruuhtians and T\'vaoans. Meant to be worn underneath a combat harness"
	icon = KIGYAR_CLOTHING_PATH
	icon_override = KIGYAR_CLOTHING_PATH
	icon_state = "jackal_bodysuit_obj"
	worn_state = "jackal_bodysuit_s"
	sprite_sheets = list("Default" = KIGYAR_CLOTHING_PATH,\
		SPECIES_KIGYAR_YW = KIGYAR_CLOTHING_PATH,\
		SPECIES_TVAOAN_KIGYAR_YW = 'code/modules/yw-halo/covenant/species/tvoan/skirm_clothing.dmi')
	species_restricted = list(SPECIES_KIGYAR_YW,SPECIES_TVAOAN_KIGYAR_YW)
	armor =  list(melee = 10, bullet = 10, laser = 0, energy = 10, bomb = 0, bio = 0, rad = 0)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	matter = list("cloth" = 1)
	rolled_sleeves = 0

/obj/item/clothing/under/kigyar/variant //Purposefully a visual change only so their armour still applies.
	name = "Kig-Yar Bodysuit (Armless)"
	icon_state = "jackal_bodysuit_armless_obj"
	worn_state = "jackal_bodysuit_r_s"
	species_restricted = list(SPECIES_KIGYAR_YW)
	rolled_sleeves = -1

/obj/item/clothing/under/kigyar/variant/one
	name = "Kig-Yar Bodysuit (Straps)"
	worn_state = "jackal_bodysuit_straps_s"

/obj/item/clothing/under/kigyar/variant/two
	name = "Kig-Yar Bodysuit (Top)"
	worn_state = "jackal_bodysuit_top_s"

/obj/item/clothing/suit/storage/armor/kigyar
	name = "Kig-Yar Combat Harness"
	desc = "A protective harness for use during combat."
	icon = KIGYAR_CLOTHING_PATH
	icon_state = "scout"
	item_state = "scout"
	sprite_sheets = list("Default" = KIGYAR_CLOTHING_PATH,\
		SPECIES_KIGYAR_YW = KIGYAR_CLOTHING_PATH,\
		SPECIES_TVAOAN_KIGYAR_YW = 'code/modules/yw-halo/covenant/species/tvoan/skirm_clothing.dmi')
	species_restricted = list(SPECIES_KIGYAR_YW,SPECIES_TVAOAN_KIGYAR_YW)
	armor = list(melee = 55, bullet = 50, laser = 55, energy = 50, bomb = 40, bio = 25, rad = 25)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	matter = list("nanolaminate" = 1)

/obj/item/clothing/suit/storage/armor/kigyar/major
	name = "Kig-Yar Major Combat Harness"
	icon_state = "scout_major"
	item_state = "scout_major"

//First Contact Variant
/obj/item/clothing/head/helmet/kigyar/first_contact
	name = "Kig-Yar Scout Helmet"
	desc = "A Kig-Yar scout helmet. Usually these come with night vision, however, this one seems to have had that removed."
	armor = list(melee = 30, bullet = 30, laser = 30,energy = 20, bomb = 25, bio = 0, rad = 0)

/obj/item/clothing/suit/storage/armor/kigyar/first_contact
	name = "Kig-Yar Combat Harness"
	desc = "A protective harness for use during combat, Seems to be missing the armour-inserts for the arms."
	armor = list(melee = 30, bullet = 40, laser = 40, energy = 40, bomb = 40, bio = 20, rad = 20)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
