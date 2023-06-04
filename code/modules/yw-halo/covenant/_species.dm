
#define COVENANT_SPECIES_AND_MOBS list(\
	/datum/species/kig_yar,\
	/datum/species/kig_yar_skirmisher,\
	/mob/living/carbon/human/covenant)

/proc/is_covenant_mob(var/mob/user)
	if(user.type in COVENANT_SPECIES_AND_MOBS)
		return 1

	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.species.type in COVENANT_SPECIES_AND_MOBS)
			return 1

	return 0