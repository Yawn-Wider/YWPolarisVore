/datum/reagent/drink/lovepotion_yw
	name = "Strawberry Love Potion"
	id = "strawberrylovepotion"
	description = "Creamy strawberries and sugar, simple and sweet."
	taste_description = "strawberries and cream"
	color = "#fc8a8a" // rgb(252, 138, 138)

	glass_name = "Love Potion"
	glass_desc = "Love me tender, love me sweet."


/datum/reagent/ethanol/wormblood
	name = "Worm Blood"
	id = "wormblood"
	description = "Who had the grand idea to bottle THE BLOOD OF A WORM."
	taste_description = "Wriggly cave fungus"
	color = "#827A00"
	strength = 30
	druggy = 10

	glass_name = "Worm blood"
	glass_desc = "Who had the grand idea to bottle THE BLOOD OF A WORM."
	glass_icon_state = "wormblood"
	glass_center_of_mass = list("x"=16, "y"=8)
	glass_icon_file = 'icons/obj/drinks_yw.dmi'




/datum/reagent/drink/antidepressant_yw
	name = "Antidepressant"
	id = "antidepressant_yw"
	description = "A soul lightenner, you can't stay sad at the taste of this."
	taste_description = "a mixture of sweet, creamy, fruityness. The pain of life dulls a bit..."
	color = "#ee757c" // rgb(238, 117, 124)

	glass_name = "Antidepresant"
	glass_desc = "A Bright red coktail, warm as a roaring chimney, and bright as a smile."

#define YW_ANTIDEPRESSANT_MESSAGE_DELAY 5*60*10

/datum/reagent/drink/antidepresant_yw/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_DIONA)
		return
	if(volume <= 0.1 && data != -1)
		data = -1
		to_chat(M, "<span class='warning'>You feel nothing...</span>")
	else
		if(world.time > data + YW_ANTIDEPRESSANT_MESSAGE_DELAY)
			data = world.time
			to_chat(M, "<b>You feel soothed...</b>")
