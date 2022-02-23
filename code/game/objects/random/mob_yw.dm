/obj/random/ce_pet
	name = "Chief Engineer Pet Spawner"
	desc = "This is spawns either poly or noodle."
	icon = 'icons/mob/animal_yw.dmi'
	icon_state = "polynoodle"

/obj/random/ce_pet/item_to_spawn()
	return pick(prob(50);/mob/living/simple_mob/animal/passive/bird/parrot/poly,
				prob(50);/mob/living/simple_mob/animal/passive/snake/python/noodle)