/mob/living/simple_mob/animal/passive/gaslamp/snow //Frostlamnp
	name = "Frostlit Lamp"
	desc = "Some sort of floaty alien with a surprisingly warm glow. This creature is looks like an evolutionary offshute of the Gaslamp family."
	tt_desc = "Semaeostomeae virginus"
	icon = 'icons/mob/cryogaia32x64.dmi'
	icon_state = "gaslamp"
	icon_living = "gaslamp"
	icon_dead = "gaslamp-dead"

	faction = "virgo3b"
	maxHealth = 100
	health = 100
	movement_cooldown = 12

	say_list_type = /datum/say_list/gaslamp
	ai_holder_type = /datum/ai_holder/simple_mob/gaslamp

//	speed = 2 Virgo coders making my life hell. This conflicts with their new system

	melee_damage_lower = 30 // Because fuck anyone who hurts this sweet, innocent creature.
	melee_damage_upper = 30
	attacktext = list("thrashed")
	friendly = "caressed"

	response_help   = "brushes"	// If clicked on help intent
	response_disarm = "pushes" // If clicked on disarm intent
	response_harm   = "swats"	// If clicked on harm intent

	minbodytemp = 0
	maxbodytemp = 350

	min_oxy = 1	//Needs Oxy to survive on cryogaia
	max_oxy = 0 // Hopefully no Max oxy
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0

//Code for chaplains pet.
/mob/living/simple_mob/clockwork
	name = "Clockwork Marauder"
	desc = "The stalwart apparition of a clockwork flame guardian. It's eternal flame glows a firey-red."
	tt_desc = "Aeterna flamma armis"
	icon = 'icons/mob/clockwork_mobs.dmi'
	icon_state = "clockwork_marauder"
	item_state = "clockwork_marauder"
	icon_living = "clockwork_marauder"
	icon_dead = "fallen_armor"
	icon_rest = "clockwork_marauder"

	movement_cooldown = 0.5 SECONDS

	see_in_dark = 6 // Not sure if this actually works.


	response_help  = "pats"
	response_disarm = "gently pushes aside"
	response_harm   = "kicks"

	min_oxy = 16 //Require atleast 16kPA oxygen
	minbodytemp = 223		//Below -50 Degrees Celcius
	maxbodytemp = 323	//Above 50 Degrees Celcius

	has_langs = list("Occursus")
/*	speak_chance = 1
	speak = list("Heretics!","Burn them!","Protect believers!","Hail Helios")
	speak_emote = list("crackles", "burns")
	emote_hear = list("crackles","burns")
	emote_see = list("twists their sword", "adjusts their shield")
	say_maybe_target = list("Who?","Strange.")
	say_got_target = list("Purge!","Cleanse!","Burn!") */

	meat_amount = 0
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat

	var/turns_since_scan = 0
	var/mob/flee_target

/mob/living/simple_mob/clockwork/handle_special()
	if(!stat && prob(2)) // spooky
		var/mob/observer/dead/spook = locate() in range(src, 5)
		if(spook)
			var/turf/T = get_turf(spook)
			var/list/visible = list()
			for(var/obj/O in T.contents)
				if(!O.invisibility && O.name)
					visible += O
			if(visible.len)
				var/atom/A = pick(visible)
				visible_emote("suddenly stops and stares at something unseen[istype(A) ? " near [A]":""].")



//Basic friend AI
/*/mob/living/simple_animal/clockwork/fluff
	var/mob/living/carbon/human/friend
	var/befriend_job = null

/mob/living/simple_animal/clockwork/fluff/Life()
	. = ..()
	if(!. || ai_inactive || !friend) return

	var/friend_dist = get_dist(src,friend)

	if (friend_dist <= 4)
		if(stance == STANCE_IDLE)
			if(set_follow(friend))
				handle_stance(STANCE_FOLLOW)

	if (friend_dist <= 1)
		if (friend.stat >= DEAD || friend.health <= config.health_threshold_softcrit)
			if (prob((friend.stat < DEAD)? 50 : 15))
				var/verb = pick("meows", "mews", "mrowls")
				audible_emote(pick("[verb] in distress.", "[verb] anxiously."))
		else
			if (prob(5))
				visible_emote(pick("nuzzles [friend].",
								   "brushes against [friend].",
								   "rubs against [friend].",
								   "purrs."))
	else if (friend.health <= 50)
		if (prob(10))
			var/verb = pick("meows", "mews", "mrowls")
			audible_emote("[verb] anxiously.")

/mob/living/simple_animal/cat/fluff/verb/become_friends()
	set name = "Become Friends"
	set category = "IC"
	set src in view(1)

	if(!friend)
		var/mob/living/carbon/human/H = usr
		if(istype(H) && (!befriend_job || H.job == befriend_job))
			friend = usr
			. = 1
	else if(usr == friend)
		. = 1 //already friends, but show success anyways

	if(.)
		set_dir(get_dir(src, friend))
		visible_emote(pick("nuzzles [friend].",
						   "brushes against [friend].",
						   "rubs against [friend].",
						   "purrs."))
	else
		usr << "<span class='notice'>[src] ignores you.</span>"
	return */

/mob/living/simple_mob/clockwork/fluff/Ignis
	name = "Ignis"
	desc = "The stalwart apparition of a clockwork flame guardian. This one appears to be  to be have been somehow modified to be 'docile', it's living fire turned blue."
//	tt_desc = "Aeterna flamma armis" //Chaplains new pet!
	icon = 'icons/mob/clockwork_mobs.dmi'
	icon_state = "ignis"
	item_state = "ignis"
//	icon_living = "ignis"
//	icon_dead = "fallen_armor"
//	icon_rest = "ignis"
//	retaliate = 1 // In theory this will make Ignis fight back. Maybe. -RF

/mob/living/simple_mob/animal/passive/mouse/mining
	body_color = "brown"
	icon = 'icons/mob/animal_yw.dmi'
	icon_state = "mouse_miner"
	item_state = "mouse_miner"
	icon_living = "mouse_miner"
	name = "Cooper"
	desc = "A lonely miner's best friend."

/mob/living/simple_mob/animal/passive/mouse/mining/New()
	..()

	verbs += /mob/living/proc/ventcrawl
	verbs += /mob/living/proc/hide
	icon_state = "mouse_miner"
	item_state = "mouse_miner"
	icon_living = "mouse_miner"
	icon_dead = "mouse_miner_dead"
	icon_rest = "mouse_miner_sleep"
	desc = "A lonely miner's best friend."


/mob/living/simple_mob/animal/passive/mouse/mining/splat()
	src.health = 0
	src.set_stat(DEAD)
	src.icon_dead = "mouse_miner_splat"
	src.icon_state = "mouse_miner_splat"
	layer = MOB_LAYER
	if(client)
		client.time_died_as_mouse = world.time

/mob/living/simple_mob/animal/passive/thrumbo
	name = "Snowbull"
	desc = "Some white furred bull with a single curved horn."
	tt_desc = "legionis gayus"
	icon = 'icons/mob/cryogaia64x64.dmi'
	icon_state = "snowbull"
	icon_living = "snowbull"
	icon_dead = "snowbull-dead"
	maxHealth = 150
	health = 150
	faction = "virgo3b"
	pixel_x = -16
	special_attack_min_range = 2
	special_attack_max_range = 8
	special_attack_cooldown = 10 SECONDS
	var/charging = 0
	var/charging_warning = 0.5 SECONDS
	minbodytemp = 0
	maxbodytemp = 1000
	min_oxy = 0				// Oxygen in moles, minimum, 0 is 'no minimum'
	max_oxy = 0					// Oxygen in moles, maximum, 0 is 'no maximum'
	min_tox = 0					// Phoron min
	max_tox = 0					// Phoron max
	min_co2 = 0					// CO2 min
	max_co2 = 0					// CO2 max
	min_n2 = 0					// N2 min
	max_n2 = 0					// N2 max
	attack_sharp = 1
	melee_damage_lower = 30 // Because fuck anyone who hurts this sweet, innocent creature.
	melee_damage_upper = 30

	ai_holder_type = /datum/ai_holder/simple_mob/gaslamp

/mob/living/simple_mob/animal/passive/thrumbo/do_special_attack(atom/A)
	set waitfor = FALSE
	set_AI_busy(TRUE)
	var/chargeturf = get_turf(A)
	if(!chargeturf)
		return
	var/dir = get_dir(src, chargeturf)
	var/turf/T = get_ranged_target_turf(chargeturf, dir, 2)
	if(!T)
		return
	charging = 1
	movement_shake_radius = 2
	movement_sound = 'sound/mecha/mechstep.ogg'
	walk(src, 0)
	set_dir(dir)
	visible_message(span("danger","\The [src] charges at \the [A]!"))
	icon_state = "snowbull-charge"
	sleep(charging_warning)
	walk_towards(src, T, 2)
	sleep((get_dist(src, T) * 2))
	walk(src, 0) // cancel the movement
	charging = 0
	icon_state = "snowbull"
	movement_shake_radius = 0
	movement_sound = null
	set_AI_busy(FALSE)

/mob/living/simple_mob/animal/passive/thrumbo/Bump(var/mob/living/M)
	if(charging)
		if(istype(M))
			visible_message("<span class='warning'>[src] knocks over [M]!</span>")
			M.Stun(5)
			M.Weaken(3)
			M.throw_at_random(0, 1, 2)
			runOver(M)
	..()

/mob/living/simple_mob/animal/passive/thrumbo/proc/runOver(var/mob/living/M)
	if(istype(M)) // At this point, MULEBot has somehow crossed over onto your tile with you still on it. CRRRNCH.
		visible_message("<span class='warning'>[src] runs over [M]!</span>")
		playsound(src, 'sound/effects/splat.ogg', 50, 1)
		var/damage = rand(5, 7)
		M.apply_damage(2 * damage, BRUTE, BP_HEAD)
		M.apply_damage(2 * damage, BRUTE, BP_TORSO)
		M.apply_damage(0.5 * damage, BRUTE, BP_L_LEG)
		M.apply_damage(0.5 * damage, BRUTE, BP_R_LEG)
		M.apply_damage(0.5 * damage, BRUTE, BP_L_ARM)
		M.apply_damage(0.5 * damage, BRUTE, BP_R_ARM)
		blood_splatter(src, M, 1)




