//Hydra
/mob/living/carbon/human/var/hydra_original_name = ""

/mob/living/carbon/human/proc/hydra_reset()
	set name = "Reset Speech"
	set category = "Abilities"
	set desc = "Go back to speaking as a whole."

	if(!hydra_original_name)
		hydra_original_name = real_name
	real_name = hydra_original_name

	src.visible_message(span_notice("[name] pushes all three heads forwards; they seem to be talking as a collective."), \
							span_notice("You are now talking as [hydra_original_name]!"), exclude_mobs= list(src))

/mob/living/carbon/human/proc/hydra_activate()
	set name = "Switch head"
	set category = "Abilities"
	set desc = "Switch between each of the heads on your body."

	if(!hydra_original_name)
		hydra_original_name = real_name
	real_name = hydra_original_name

	var/list/names = splittext(hydra_original_name,"-")
	var/selhead = tgui_input_list(usr, "Who would you like to speak as?","Heads:", names)
	real_name = selhead
	src.visible_message(span_notice("[name] pulls the rest of their heads back; and puts [selhead]'s forward."), \
							span_notice("You are now talking as [selhead]!"), exclude_mobs= list(src))

//Hydra end
