/datum/robolimb/eioni
	company = "Eio'ni Co."
	desc = "Eio'ni's brand prosthetic limbs."
	icon = 'icons/mob/human_races/cyberlimbs/eioni/eioni_main.dmi' //Sprited by: Unleashed Mana

/datum/robolimb/eioni_alt1
	company = "Eio'ni Co. - Heads"
	desc = "Eio'ni's brand heads with mounted display."
	icon = 'icons/mob/human_races/cyberlimbs/eioni/eioni_alt1.dmi' //Sprited by: Unleashed Mana
	parts = list(BP_HEAD)
	monitor_styles = standard_monitor_styles

/datum/robolimb/s_Ind
	company = "S.Ind"
	desc = "S.Ind brand prosthetic limbs."
	icon = 'icons/mob/human_races/cyberlimbs/S.Ind/sind_main.dmi' //Sprited by: Generalpantsu

/datum/robolimb/Hperformance
	company = "Hperformance."
	desc = "Hperformance brand prosthetic limbs."
	icon = 'icons/mob/human_races/cyberlimbs/Hperformance/hperformance_main.dmi' //Sprited by: Generalpantsu

/datum/robolimb/xionalt
	company = "Xion (alt yw)."
	desc = "Xion brand prosthetic limbs."
	icon = 'icons/mob/human_races/cyberlimbs/xion/xion_alt5.dmi' //Sprited by: Whiteout

/datum/robolimb/aphrodite_cyberdoe
	company = "Aphrodite - Cyberdoe"
	desc = "This limb feels soft and fluffy, realistic in design and squish. By Aphrodite Ltd."
	icon = 'icons/mob/human_races/cyberlimbs/aphrodite/andy_taj.dmi'
	blood_color = "#ffe2ff"
	lifelike = 1
	unavailable_to_build = 1
	includes_tail = 0
	suggested_species = "Tajara"
	whitelisted_to = list("dameonowen")

/datum/robolimb/aphrodite_cyberdragon
	company = "Aphrodite - Cyberdragon"
	desc = "This limb feels smooth and scalie, realistic in design and squish. By Aphrodite Ltd."
	icon = 'icons/mob/human_races/cyberlimbs/aphrodite/andy_liz.dmi'
	blood_color = "#ffe2ff"
	lifelike = 1
	unavailable_to_build = 1
	includes_tail = 0
	suggested_species = "Unathi"
	whitelisted_to = list("dameonowen")

/datum/robolimb/dopiotl_jeanne
	company = "Jeanne - Nanovulp"
	desc = ""
	icon = 'icons/mob/human_races/cyberlimbs/dopiotl/jeanne_nanovulp.dmi'
	monitor_icon = 'icons/mob/human_races/cyberlimbs/dopiotl/nanovulp_animations.dmi'
	lifelike = 1
	unavailable_to_build = 1
	includes_tail = 0
	suggested_species = "Vuplkanin"
	whitelisted_to = list("dopiotl")
	monitor_styles = "idle=idle;\
		idle-eye=eyeidle;\
		emptyinput=emptyinput;\
		rainbow=rainbow;\
		snow=snow;\
		robocop=robocop;\
		rainbowcop=rainbowcop"

/datum/robolimb/vox/improvised
	company = "Vox - Improvised"
	species_cannot_use = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_SKRELL, SPECIES_UNATHI, SPECIES_TAJ, SPECIES_TESHARI, SPECIES_NEVREAN, SPECIES_AKULA, SPECIES_SERGAL, SPECIES_FENNEC, SPECIES_ZORREN_HIGH, SPECIES_VULPKANIN, SPECIES_XENOCHIMERA, SPECIES_XENOHYBRID, SPECIES_VASILISSAN, SPECIES_RAPALA, SPECIES_PROTEAN, SPECIES_ALRAUNE, SPECIES_WEREBEAST, SPECIES_SHADEKIN, SPECIES_SHADEKIN_CREW, SPECIES_SHADEKIN_YW, SPECIES_PROMETHEAN, SPECIES_DIONA, SPECIES_GREY_YW, SPECIES_ZADDAT, SPECIES_CUSTOM)
	suggested_species = SPECIES_VOX
	desc = "A crude amalgamation of scrap that somehow just works."
	icon = 'icons/mob/human_races/cyberlimbs/vox/improvised_yw.dmi'
	unavailable_to_build = 1
	includes_tail = 1
	modular_bodyparts = MODULAR_BODYPART_PROSTHETIC

/datum/robolimb/vox/arkmade
	company = "Vox - Arkmade"
	species_cannot_use = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_SKRELL, SPECIES_UNATHI, SPECIES_TAJ, SPECIES_TESHARI, SPECIES_NEVREAN, SPECIES_AKULA, SPECIES_SERGAL, SPECIES_FENNEC, SPECIES_ZORREN_HIGH, SPECIES_VULPKANIN, SPECIES_XENOCHIMERA, SPECIES_XENOHYBRID, SPECIES_VASILISSAN, SPECIES_RAPALA, SPECIES_PROTEAN, SPECIES_ALRAUNE, SPECIES_WEREBEAST, SPECIES_SHADEKIN, SPECIES_SHADEKIN_CREW, SPECIES_SHADEKIN_YW, SPECIES_PROMETHEAN, SPECIES_DIONA, SPECIES_GREY_YW, SPECIES_ZADDAT, SPECIES_CUSTOM)
	suggested_species = SPECIES_VOX
	desc = "A bizzare limb made from a strange green metal that seemingly squirms on touch."
	icon = 'icons/mob/human_races/cyberlimbs/vox/primalis_yw.dmi'
	includes_tail = 1
	unavailable_to_build = 1
	modular_bodyparts = MODULAR_BODYPART_PROSTHETIC