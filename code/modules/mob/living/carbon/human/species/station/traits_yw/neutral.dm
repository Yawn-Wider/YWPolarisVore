/datum/trait/neutral/hot_blood
	name = "Hot-Blooded"
	desc = "You are too hot at the standard 20C. 18C is more suitable. Rolling down your jumpsuit or being unclothed helps."
	cost = 0
	var_changes = list("heat_discomfort_level" = T0C+19)
	excludes = list(/datum/trait/neutral/cold_blood, /datum/trait/neutral/extreme_cold_blood)

/datum/trait/neutral/cold_blood
	name = "Cold-Blooded"
	desc = "You are too cold at the standard 20C. 22C is more suitable. Wearing clothing that covers your legs and torso helps."
	cost = 0
	var_changes = list("cold_discomfort_level" = T0C+21)
	excludes = list(/datum/trait/neutral/hot_blood, /datum/trait/neutral/cold_blood)

/datum/trait/neutral/extreme_cold_blood
	name = "Extremely Cold Blooded"
	desc = "Your body relies on the outside temperature to keep warm. Wearing warm clothing such as jackets is commonplace for you."
	cost = 0
	var_changes = list("cold_discomfort_level" = T0C+24)
	excludes = list(/datum/trait/neutral/hot_blood, /datum/trait/neutral/cold_blood)

/datum/trait/neutral/alcohol_intolerance_basic
	name = "Liver of Lilies"
	desc = "You have a hard time with alcohol. Maybe you just never took to it, or maybe it doesn't agree with you... either way, drinks hit twice as hard. You may wish to note this down in your medical records, and perhaps your exploitable info as well."
	cost = 0
	var_changes = list("chem_strength_alcohol" = 2)

/datum/trait/neutral/alcohol_tolerance_basic
	name = "Liver of Iron"
	desc = "You can hold drinks much better than those lily-livered land-lubbers! Arr! You may wish to note this down in your medical records."
	cost = 0
	var_changes = list("chem_strength_alcohol" = 0.75)


/datum/trait/neutral/autohiss_vassilian
	name = "Autohiss (Vassilian)"
	desc = "You buzz your S's, F's, Th's, and R's."
	cost = 0
	var_changes = list(
	autohiss_basic_map = list(
        "s" = list("sz", "z", "zz"),
        "f" = list("zk")
		),
	autohiss_extra_map = list(
		"th" = list("zk", "szk"),
        "r" = list("rk")
	),
	autohiss_exempt = list("Vespinae"))
	excludes = list(/datum/trait/neutral/autohiss_tajaran, /datum/trait/neutral/autohiss_unathi)

/*/datum/trait/neutral/cryogenic
	name = "Cryogenic Metabolism"
	desc = "Your body requires near cryogenic temperatures to operate. Extremely intricate arrangements are needed for you to remain indoors. The outdoors is comfortable for you, however. WARNING: You will spawn in an atmosphere that is VERY hostile to you with no protective equipment!"
	cost = 0
	var_changes = list("heat_discomfort_level" = T0C)
	excludes = list(/datum/trait/hot_blood,/datum/trait/cold_blood,/datum/trait/extreme_cold_blood)
*/

/datum/trait/neutral/hydra_heads
	name = "Hydra Heads"
	desc = "You are a tri-headed creature. To use, format name like (Rucks-Sucks-Ducks)"
	cost = 0

/datum/trait/neutral/hydra_heads/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..()
	H.verbs |= /mob/living/carbon/human/proc/hydra_activate
	H.verbs |= /mob/living/carbon/human/proc/hydra_reset
//End hydra
