// Note for newly added fluff items: Ckeys should not contain any spaces, underscores or capitalizations,
// or else the item will not be usable.
// Example: Someone whose username is "Master Pred_Man" should be written as "masterpredman" instead
// Note: Do not use characters such as # in the display_name. It will cause the item to be unable to be selected.

/datum/gear/fluff
	path = /obj/item
	sort_category = "Fluff Items"
	display_name = "If this item can be chosen or seen, ping a coder immediately!"
	ckeywhitelist = list("This entry should never be choosable with this variable set.") //If it does, then that means somebody fucked up the whitelist system pretty hard
	character_name = list("This entry should never be choosable with this variable set.")
	cost = 0
/*
/datum/gear/fluff/testhorn
	path = /obj/item/weapon/bikehorn
	display_name = "Airhorn - Example Item"
	description = "An example item that you probably shouldn't see!"
	ckeywhitelist = list("mewchild")
	allowed_roles = list("Engineer")
*/


/datum/gear/fluff/collar //Use this as a base path for collars if you'd like to set tags in loadout. Make sure you don't use apostrophes in the display name or this breaks!
	slot = slot_tie

/datum/gear/fluff/collar/New()
	..()
	gear_tweaks += gear_tweak_collar_tag

//  0-9 CKEYS

//  A CKEYS

//  B CKEYS

//  C CKEYS

//  D CKEYS

//  E CKEYS

//  F CKEYS

//  G CKEYS

//  H CKEYS

//  I CKEYS

//  J CKEYS

//  K CKEYS

//  L CKEYS

//  M CKEYS

//  N CKEYS

//  O CKEYS

//  P CKEYS

//  Q CKEYS

//  R CKEYS

//  S CKEYS

//  T CKEYS

//  U CKEYS

//  V CKEYS

//  W CKEYS

//  X CKEYS

//  Y CKEYS

//  Z CKEYS
