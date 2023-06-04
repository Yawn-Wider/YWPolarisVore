/datum/species/kig_yar
	name = SPECIES_KIGYAR_YW
	name_plural = SPECIES_KIGYAR_YW
	blurb = "Ruutian Kig'Yar are the most commonly encountered species of Kig'Yar, known as Jackals. \
		They have an avian appearance and serve as light infantry in combat, being equipped with either \
		light weaponry and large energy defence point defence shields or (less frequently) marksman weaponry \
		due to their enhanced hearing and eyesight. Kig'Yar feud with Unggoy for status as the lowest ranked\
		members of the Covenant."
	flesh_color = "#FF9463"
	blood_color = "#532476"
	icobase = 'code/modules/yw-halo/covenant/species/kigyar/r_kig-yar.dmi' //The DMI needed modification to fit the usual format (see other species' dmis)
	deform = 'code/modules/yw-halo/covenant/species/kigyar/r_kig-yar.dmi'
	default_language = LANGUAGE_KIGYAR
	language = LANGUAGE_GALCOM
	species_language = LANGUAGE_KIGYAR
	num_alternate_languages = 3
	inherent_verbs = list(/mob/living/carbon/human/proc/focus_view)
	spawn_flags = SPECIES_CAN_JOIN
	flags = NO_MINOR_CUT
	appearance_flags = HAS_SKIN_COLOR | HAS_HAIR_COLOR | HAS_EYE_COLOR
	darksight = 6
	brute_mod = 1.1
	burn_mod = 1.1
	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/bird_punch)

	has_limbs = list(
		BP_TORSO =  list("path" = /obj/item/organ/external/chest),
		BP_GROIN =  list("path" = /obj/item/organ/external/groin),
		BP_HEAD =   list("path" = /obj/item/organ/external/head/kigyar),
		BP_L_ARM =  list("path" = /obj/item/organ/external/arm/hollow_bones),
		BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right/hollow_bones),
		BP_L_LEG =  list("path" = /obj/item/organ/external/leg/hollow_bones),
		BP_R_LEG =  list("path" = /obj/item/organ/external/leg/right/hollow_bones),
		BP_L_HAND = list("path" = /obj/item/organ/external/hand/hollow_bones),
		BP_R_HAND = list("path" = /obj/item/organ/external/hand/right/hollow_bones),
		BP_L_FOOT = list("path" = /obj/item/organ/external/foot/hollow_bones),
		BP_R_FOOT = list("path" = /obj/item/organ/external/foot/right/hollow_bones)
		)

	has_organ = list(
		O_HEART =    /obj/item/organ/internal/heart,
		O_LUNGS =    /obj/item/organ/internal/lungs,
		O_VOICE = 	/obj/item/organ/internal/voicebox,
		O_LIVER =    /obj/item/organ/internal/liver,
		O_KIDNEYS =  /obj/item/organ/internal/kidneys,
		O_BRAIN =    /obj/item/organ/internal/brain,
		O_EYES =     /obj/item/organ/internal/eyes,
		O_STOMACH =		/obj/item/organ/internal/stomach,
		O_INTESTINE =	/obj/item/organ/internal/intestine
		)


	male_scream_sound = 'code/modules/yw-halo/sounds/species_pain_screams/kiggyscream_1.ogg'
	female_scream_sound = 'code/modules/yw-halo/sounds/species_pain_screams/kiggyscream_2.ogg'

/mob/living/carbon/human/covenant/kigyar/New(var/new_loc)
	. = ..(new_loc,SPECIES_KIGYAR_YW)

/obj/item/clothing/shoes/ruutian_boots/dropped(mob/user as mob)
	. = ..()
	if(isnull(src.gc_destroyed))
		qdel(src)

/datum/unarmed_attack/bird_punch
    attack_verb = list("claws", "strikes", "slashes", "rips", "bites")
    attack_noun = list("talon")
    eye_attack_text = "talons"
    eye_attack_text_victim = "digits"
    damage = 0
    sharp = 1
    edge = 1

/obj/item/organ/external/head/kigyar
	eye_icon = "eyes_s"
	eye_icon_location = 'code/modules/yw-halo/covenant/species/kigyar/r_kig-yar.dmi'


#define ONETILE 32 //A single normal tile in pixels

/mob/living/carbon/human/proc/focus_view()
	set category = "Abilities"
	set name = "Focus View"
	set desc = "Focus your eyes on distant objects."

	if(last_special > world.time)
		return

	if((src.client.pixel_y != 0)||(src.client.pixel_x != 0))
		src.client.pixel_y = 0
		src.client.pixel_x = 0
		return

	src.reset_view(src)
	if(machine)
		to_chat(src,"<span class = 'notice'>You can't do that!</span>")
		return

	switch(src.dir)
		if(NORTH)
			src.client.pixel_y = ONETILE * 10
		if(SOUTH)
			src.client.pixel_y = ONETILE * -10
		if(EAST)
			src.client.pixel_x = ONETILE * 10
		if(WEST)
			src.client.pixel_x = ONETILE * -10

#undef ONETILE

/obj/item/organ/external/arm/hollow_bones
	min_broken_damage = 20 //Needs 10 less damage to break

/obj/item/organ/external/arm/right/hollow_bones
	min_broken_damage = 20

/obj/item/organ/external/leg/hollow_bones
	min_broken_damage = 20

/obj/item/organ/external/leg/right/hollow_bones
	min_broken_damage = 20

/obj/item/organ/external/hand/hollow_bones
	min_broken_damage = 20

/obj/item/organ/external/hand/right/hollow_bones
	min_broken_damage = 20

/obj/item/organ/external/foot/hollow_bones
	min_broken_damage = 20

/obj/item/organ/external/foot/right/hollow_bones
	min_broken_damage = 20
