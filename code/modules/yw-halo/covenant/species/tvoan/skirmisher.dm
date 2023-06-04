/datum/species/kig_yar_skirmisher
	name = SPECIES_TVAOAN_KIGYAR_YW
	name_plural = SPECIES_TVAOAN_KIGYAR_YW
	blurb = "T'vaoan Skirmishers are the same species as the more common, lightly-built Ruutian Jackals, but \
		they are subspecies that is faster, stronger, can jump higher and are more agile than any ordinary Kig-Yar. In addition, \
		they sport manes of feathers rather than quills. A Skirmisher's voice is more raspy and guttural - this is \
		because they have an expanded voice chamber in their throat. Skirmishers serve as Covenant shock troopers \
		and close-range combatants, attacking in packs and using flanking tactics. Kig'Yar feud with Unggoy for \
		status as the lowest ranked members of the Covenant."
	flesh_color = "#FF9463"
	blood_color = "#532476"
	default_language = LANGUAGE_TVOAI
	language = LANGUAGE_GALCOM
	species_language = LANGUAGE_TVOAI
	num_alternate_languages = 3
	icobase = 'code/modules/yw-halo/covenant/species/tvoan/r_skirmishers.dmi'
	deform = 'code/modules/yw-halo/covenant/species/tvoan/r_skirmishers.dmi'
	icon_template = 'code/modules/yw-halo/covenant/species/tvoan/r_skirmisher_template.dmi'
	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/bird_punch)
	appearance_flags = HAS_SKIN_COLOR | HAS_HAIR_COLOR | HAS_EYE_COLOR
	spawn_flags = SPECIES_CAN_JOIN

	pain_mod = 0.9
	brute_mod = 1.2
	burn_mod = 1.2
	slowdown = -0.4

	gibbed_anim = null
	dusted_anim = null

	has_limbs = list( //Normal limbs. A bit better than ruutian
		BP_TORSO =  list("path" = /obj/item/organ/external/chest),
		BP_GROIN =  list("path" = /obj/item/organ/external/groin),
		BP_HEAD =   list("path" = /obj/item/organ/external/head/tvoan),
		BP_L_ARM =  list("path" = /obj/item/organ/external/arm),
		BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right),
		BP_L_LEG =  list("path" = /obj/item/organ/external/leg),
		BP_R_LEG =  list("path" = /obj/item/organ/external/leg/right),
		BP_L_HAND = list("path" = /obj/item/organ/external/hand),
		BP_R_HAND = list("path" = /obj/item/organ/external/hand/right),
		BP_L_FOOT = list("path" = /obj/item/organ/external/foot),
		BP_R_FOOT = list("path" = /obj/item/organ/external/foot/right)
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



	male_scream_sound = 'code/modules/yw-halo/sounds/species_pain_screams/skirmisherscream_1.ogg'
	female_scream_sound = 'code/modules/yw-halo/sounds/species_pain_screams/skirmisherscream_2.ogg'
/mob/living/carbon/human/covenant/tvoan/New(var/new_loc)
	. = ..(new_loc,SPECIES_TVAOAN_KIGYAR_YW)
	faction = "Covenant"

/obj/item/organ/external/head/tvoan
	eye_icon = "eyes_s"
	eye_icon_location = 'code/modules/yw-halo/covenant/species/tvoan/r_skirmishers.dmi'
