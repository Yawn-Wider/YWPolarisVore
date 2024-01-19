/mob/living/simple_mob/vox/armalis
	name = "serpentine alien"
	real_name = "serpentine alien"
	desc = "A one-eyed, serpentine creature, half-machine, easily nine feet from tail to beak!"
	icon = 'icons/mob/vox.dmi'
	icon_state = "armalis"
	icon_living = "armalis"
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	maxHealth = 500
	health = 500
	taser_kill = 0
	has_langs = list(LANGUAGE_VOX)
	ic_revivable = 1
	has_hands = 1
	response_harm = "slashes at the"
	harm_intent_damage = 0
	melee_damage_lower = 30
	melee_damage_upper = 40
	attack_sharp = 1
	attacktext = "slammed its enormous claws into"
	movement_cooldown = 2
//	environment_smash_flags = SMASH_LIGHT_STRUCTURES | SMASH_CONTAINERS | SMASH_WALLS // WALLS Temporary commenting, YW - Hv3
	attack_sound = 'sound/weapons/bladeslice.ogg'
	status_flags = 0
	max_oxy = 0

	var/armour = null
	var/amp = null
	var/quills = 3

/mob/living/simple_mob/vox/armalis/death(var/gibbed = FALSE)
	..(TRUE)
	var/turf/gloc = get_turf(loc)
	visible_message("<span class='danger'><B>[src] shudders violently and explodes!</B>","<span class='warning'>You feel your body rupture!</span></span>")
	gib()
	explosion(gloc, -1, -1, 3, 5)
	qdel(src)

/mob/living/simple_mob/vox/armalis/attackby(var/obj/item/O as obj, var/mob/user as mob)
	base_attack_cooldown = 5
	if(O.force)
		if(O.force >= 25)
			var/damage = O.force
			if (O.damtype == HALLOSS)
				damage = 0
			health -= damage
			for(var/mob/M in viewers(src, null))
				if ((M.client && !( M.blinded )))
					M.show_message("<span class='danger'>[src] has been attacked with the [O] by [user]. </span>")
		else
			for(var/mob/M in viewers(src, null))
				if ((M.client && !( M.blinded )))
					M.show_message("<span class='danger'>The [O] bounces harmlessly off of [src]. </span>")
	else
		to_chat(usr, "<span class='warning'>This weapon is ineffective, it does no damage.</span>")
		for(var/mob/M in viewers(src, null))
			if ((M.client && !( M.blinded )))
				M.show_message("<span class='warning'>[user] gently taps [src] with the [O]. </span>")

/mob/living/simple_mob/vox/armalis/verb/fire_quill(mob/target as mob in oview())
	set name = "Fire quill"
	set desc = "Fires a viciously pointed quill at a high speed."
	set category = "Alien"

	if(quills<=0)
		return

	to_chat(src, "<span class='warning'>You launch a razor-sharp quill at [target]!</span>")
	for(var/mob/O in oviewers())
		if ((O.client && !( O.blinded )))
			to_chat(O, "<span class='warning'>[src] launches a razor-sharp quill at [target]!</span>")

	var/obj/item/weapon/arrow/quill/Q = new(loc)
	Q.fingerprintslast = src.ckey
	Q.throw_at(target,10,30)
	quills--

	spawn(100)
		to_chat(src, "<span class='warning'>You feel a fresh quill slide into place.</span>")
		quills++

/mob/living/simple_mob/vox/armalis/verb/message_mob()
	set category = "Alien"
	set name = "Commune with creature"
	set desc = "Send a telepathic message to an unlucky recipient."

	var/list/targets = list()
	var/target = null
	var/text = null

	targets += getmobs() //Fill list, prompt user with list
	for(var/key in targets)
		var/mob/mobx = targets[key]
		if(!mobx.ckey)
			targets -= key

	target = tgui_input_list(src, "Select a creature!", "Speak to creature", targets)

	if(!target) return

	text = tgui_input_text(src, "What would you like to say?", "Speak to creature")

	if (!target || !text)
		return

	var/mob/M = targets[target]

	if(istype(M, /mob/observer/dead) || M.stat == DEAD)
		to_chat(src, "Not even the armalis can speak to the dead.")
		return

	to_chat(M, "<span class='notice'>Like lead slabs crashing into the ocean, alien thoughts drop into your mind: [text]</span>")
	if(istype(M,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		if(H.species.name == SPECIES_VOX)
			return
		to_chat(H, "<span class='warning'>Your nose begins to bleed...</span>")
		H.drip(1)

/mob/living/simple_mob/vox/armalis/verb/shriek()
	set category = "Alien"
	set name = "Shriek"
	set desc = "Give voice to a psychic shriek."

/mob/living/simple_mob/vox/armalis/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if(istype(O,/obj/item/vox/armalis_armour))
		user.drop_item(O, src)
		armour = O
		movement_cooldown = 4
		maxHealth += 200
		health += 200
		visible_message("<span class='notice'>[src] is quickly outfitted in [O] by [user].</span>","<span class='notice'>You quickly outfit [src] in [O].</span>")
		update_icon()
		return
	if(istype(O,/obj/item/vox/armalis_amp))
		user.drop_item(O, src)
		amp = O
		visible_message("<span class='notice'>[src] is quickly outfitted in [O] by [user].</span>","<span class='notice'>You quickly outfit [src] in [O].</span>")
		update_icon()
		return
	return ..()

/mob/living/simple_mob/vox/armalis/update_icon()
	. = ..()
	if(armour)
		var/icon/armour = image('icons/mob/vox.dmi',"armour")
		movement_cooldown = 4
		add_overlay(armour)
	if(amp)
		var/icon/amp = image('icons/mob/vox.dmi',"amplifier")
		add_overlay(amp)

/obj/item/vox/armalis_armour
	name = "strange armour"
	desc = "Hulking reinforced armour for something huge."
	icon = 'icons/inventory/suit/item.dmi'
	icon_state = "armalis_armour"
	item_state = "armalis_armour"

/obj/item/vox/armalis_amp
	name = "strange lenses"
	desc = "A series of metallic lenses and chains."
	icon = 'icons/inventory/suit/item.dmi'
	icon_state = "amp"
	item_state = "amp"
