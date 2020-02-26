/datum/species/biosynthetic
	name = SPECIES_BIOSYNTH
	name_plural = "Biosynthetics"
	selects_bodytype = TRUE
	base_species = SPECIES_HUMAN

	num_alternate_languages = 3
	assisted_langs = list(LANGUAGE_ROOTLOCAL, LANGUAGE_ROOTGLOBAL) //biosynths can 'naturally' speak basically anything
	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/punch, /datum/unarmed_attack/bite)
	inherent_verbs = list(
		/mob/living/carbon/human/proc/tie_hair,
		/mob/living/proc/shred_limb) //Biosynths get a couple extra verbs, but they're too heavy to fly even with wings!

	virus_immune = 1 // natch
	has_glowing_eyes = 1 // biosynth eyes tend to glow in the dark
	genders = list(MALE, FEMALE, NEUTER) //biosynths come in three core flavors

	speech_bubble_appearance = "radio" //subtly different - had to add a new state for typing

	//0C is 273.15
	cold_level_1 = 240 //-33C - default 260K/-13C
	cold_level_2 = 180 //-93C - default 200K/-73C
	cold_level_3 = 100 //-173C - default 120K/-153C
	cold_discomfort_level = 270 //biosynths care much less about low temps, so we won't get warnings until -3C (humans get discomfort messages at around 12C)
	cold_discomfort_strings = list(
		"Your internal monitoring reports decreasing temperatures approaching safe operating limits.",
		"You feel the chill starting to impede your biosynthetic functions.",
		"Your core systems are responding somewhat sluggishly."
		)

	//however, they're worse at handling high extremes, keeping in line with their burn weakness
	heat_level_1 = 340 //66C - default 360K/86C
	heat_level_2 = 380 //106C - default 400K/126C
	heat_level_3 = 900 //626C - default 1000K/726C
	heat_discomfort_level = 305 //vanilla level minus ten, so biosynths have a little more warning about heat damage, starting at 31C
	heat_discomfort_strings = list(
		"Your internal monitoring reports rising temperatures approaching safe operating limits.",
		"You feel the heat starting to impede your biosynthetic functions.",
		"Your core systems are responding rather erratically."
		)

	min_age = 18
	max_age = 150 //biosynths are functionally immortal if properly maintained, but let's not encourage people too much (and they are somewhat-new)

	economic_modifier = 10
	metabolic_rate = 0.2				// Biosynths *can* process reagents, and with no unusual effects, but they do so *extremely* slowly; 45 brute takes around 5 minutes w/ injected bica.
	bloodloss_rate = 0.8				// Biosynth 'blood' is thicker and thus lost slower. offsets the fact it's harder for them to regen it (iron will be processed slower, etc.)
	hunger_factor = 0.10				// On the other hand their energy demands are quite high, so they need to eat almost as often as tesh
							// I tried cranking it higher but it turns out that didn't play well with the reduced metabolic rate; you'd starve faster than you can metabolize nutrition from food

	total_health = 		125			// They're technically not as durable as a custom species with the right traits in terms of raw HP, but their pain immunity and softcrit mechanics pick up a lot of slack
	blood_volume = 		700			// Biosynths have a dual purpose neurovascular system, so there's more vessels - and more 'blood' filling the network
	brute_mod =     	1			// No change here, for now. Their increased health pool and pain immunity is more than enough.
	burn_mod =      	1.2			// Biosynthetic 'tissue' sort of... 'melts'. It's really gross. And it smells absolutely horrendous.
	oxy_mod =		0			// No oxy damage from any source, just to be safe. Might help with crit stuff?
	toxins_mod =		0			// Ditto toxins damage. In case NO_POISON has some weird edge-cases or whatever.
	radiation_mod =		0.2			// Biosynths don't really give a shit about radiation, but too much of it can still have bad effects on them.
	flash_mod =		1.5			// High-quality optical sensors mean flash-sensitivity built in.
	sound_mod =		1.5			// Sensitive audio receptors are extra-vulnerable to the bang part of flashbangs, too.
	siemens_coefficient = 	1.5			// The biosynthetic neurovascular system is a little *too* good at what it does. They really, really don't like getting shocked.
	body_temperature = 	315.15			// We run hot! a toasty core temp of 42C
	
	meat_type = null				// You really don't want to cook biosynth flesh, so we don't give meat.

	// biosynths don't really breathe like organics, but they do need O2 for their chemical furnace (read: guts) and as a secondary cooling medium
	// for now these are all nulled, but ideally I want an override that basically sets their already-glacial metabolic rate to 0 if they have no clean air coming in
	// and it could possibly incur other penalties, such as reduction in movement speed?
	breath_type = null
	poison_type = null				// On the plus side, no particular gas type is toxic to them
	exhale_type = null

	death_message = "suddenly seizes up, then goes slack..."
	knockout_message = "collapses, unresponsive!"
	show_ssd = "disconcertingly still"

	blurb = "Artificially-created humanoids made of synthetic materials, biosynthetics blur the line between mortal and machine to a degree that many find unsettling (if not downright terrifying) as biosynths can be nigh impossible to tell apart from regular flesh and blood beings without deep-tissue inspections. They are highly durable, generally fearless, and do not feel pain. Contrary to certain depictions, however, their emotional range is more or less equivalent to those of normal people, and thus they can in fact feel pity and remorse, and can usually be reasoned with."

	//wikilink = "https://www.yawn.ocry.com/Biosynthetic"

	//catalogue_data = list(/datum/category_item/catalogue/fauna/biosynthetic)

	primitive_form = null

	spawn_flags = SPECIES_CAN_JOIN | SPECIES_NO_FBP_CONSTRUCTION | SPECIES_NO_FBP_CHARGEN
	flags = NO_SCAN | NO_INFECT | NO_PAIN | NO_POISON //Biosynth 'DNA' is impossible to replicate. On the plus side, immune to infections and viruses, don't feel pain, and most toxins don't hurt them
	reagent_tag = IS_BIOSYNTH	//I don't have any unique interactions in mind right now, but it might be possible to come up with some stuff later?
	appearance_flags = HAS_HAIR_COLOR | HAS_LIPS | HAS_UNDERWEAR | HAS_SKIN_COLOR | HAS_EYE_COLOR

	has_organ = list(
		O_HEART =    		/obj/item/organ/internal/heart/biosynth,
		O_LUNGS =    		/obj/item/organ/internal/lungs/biosynth,
		O_VOICE = 		/obj/item/organ/internal/voicebox/biosynth,
		O_LIVER =    		/obj/item/organ/internal/liver/biosynth,
		O_KIDNEYS =  		/obj/item/organ/internal/kidneys/biosynth,
		O_BRAIN =    		/obj/item/organ/internal/brain/biosynth,
		O_EYES =     		/obj/item/organ/internal/eyes/biosynth,
		O_STOMACH =		/obj/item/organ/internal/stomach/biosynth,
		O_INTESTINE =		/obj/item/organ/internal/intestine/biosynth
		)

	flesh_color	= "#696969"		//gross greyblack flesh
	base_color	= "#333333"		//normal on the outside, at least?
	blood_color	= "#708090"		//weird greyish synthetic blood!

/datum/species/biosynthetic/proc/produceCopy(var/datum/species/to_copy,var/list/traits,var/mob/living/carbon/human/H)
	ASSERT(to_copy)
	ASSERT(istype(H))

	if(ispath(to_copy))
		to_copy = "[initial(to_copy.name)]"
	if(istext(to_copy))
		to_copy = GLOB.all_species[to_copy]

	var/datum/species/biosynthetic/new_copy = new()

	//Initials so it works with a simple path passed, or an instance
	new_copy.base_species = to_copy.name
	new_copy.icobase = to_copy.icobase
	new_copy.deform = to_copy.deform
	new_copy.tail = to_copy.tail
	new_copy.tail_animation = to_copy.tail_animation
	new_copy.icobase_tail = to_copy.icobase_tail
	new_copy.color_mult = to_copy.color_mult
	new_copy.primitive_form = to_copy.primitive_form
	new_copy.appearance_flags = to_copy.appearance_flags
	new_copy.flesh_color = to_copy.flesh_color
	new_copy.base_color = to_copy.base_color
	new_copy.blood_mask = to_copy.blood_mask
	new_copy.damage_mask = to_copy.damage_mask
	new_copy.damage_overlays = to_copy.damage_overlays

	//Set up a mob
	H.species = new_copy
	H.icon_state = lowertext(new_copy.get_bodytype())

	if(new_copy.holder_type)
		H.holder_type = new_copy.holder_type

	if(H.dna)
		H.dna.ready_dna(H)

	return new_copy

/datum/species/biosynthetic/get_bodytype()
	return base_species

/datum/species/biosynthetic/get_race_key()
	var/datum/species/real = GLOB.all_species[base_species]
	return real.race_key

/datum/species/biosynthetic/can_breathe_water()
	return TRUE	//biosynths don't really breathe like organics do - it's complicated

//adds special items here so we don't have to include/edit any more files

/datum/supply_pack/med/biosynthorgans
	name = "Replacement biosynthetic organs"
	contains = list(
			/obj/item/organ/internal/heart/biosynth,
			/obj/item/organ/internal/lungs/biosynth,
			/obj/item/organ/internal/voicebox/biosynth,
			/obj/item/organ/internal/liver/biosynth,
			/obj/item/organ/internal/kidneys/biosynth,
			/obj/item/organ/internal/eyes/biosynth,
			/obj/item/organ/internal/stomach/biosynth,
			/obj/item/organ/internal/intestine/biosynth
			)
	cost = 50 //cost is reasonably high as these are essentially "universal" organs that don't rot
	containertype = /obj/structure/closet/crate/secure
	containername = "Biosynthetic organs"
	access = access_medical_equip