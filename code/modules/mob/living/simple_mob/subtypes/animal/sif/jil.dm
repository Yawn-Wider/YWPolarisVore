/datum/category_item/catalogue/fauna/sakimm/jil
	name = "Jil"
	desc = ""
	value = CATALOGUER_REWARD_EASY

/mob/living/simple_mob/animal/sif/sakimm/jil
	name = "jil"
	real_name = "jil"
	desc = "It's a small rodent."
	tt_desc = "E Mus musculus"
	icon_state = "mouse_gray"
	item_state = "mouse_gray"
	icon_living = "mouse_gray"
	icon_dead = "mouse_gray_dead"
	kitchen_tag = "rodent"

	icon_state = "mouse_gray"

	faction = "jil"

	maxHealth = 5
	health = 5
	has_hands = TRUE
	humanoid_hands = TRUE
	minbodytemp = 175
	pass_flags = PASSTABLE
	
	universal_understand = 1

	melee_damage_lower = 1
	melee_damage_upper = 1
	base_attack_cooldown = 1 SECOND
	attacktext = list("nipped", "bit", "cut", "clawed")

	movement_cooldown = 1.5
	animate_movement = SLIDE_STEPS

	layer = MOB_LAYER
	density = FALSE

	response_help  = "pets"
	response_disarm = "gently pushes aside"
	response_harm   = "stamps on"

	has_langs = list("Jil")
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat

	say_list_type = /datum/say_list/jil
	ai_holder_type = /datum/ai_holder/simple_mob/intentional/sakimm/jil
	randomize_size = FALSE	// Most likely to have a hat.
	melee_attack_delay = 0	// For some reason, having a delay makes item pick-up not work.

	friend_loot_list = list()	// What will make this animal non-hostile if held?

/mob/living/simple_mob/animal/sif/sakimm/jil/Crossed(atom/movable/AM as mob|obj)
	if(AM.is_incorporeal())
		return
	if( ishuman(AM) )
		if(!stat)
			var/mob/M = AM
			M.visible_message("<font color='blue'>[bicon(src)] Merp!</font>")
			playsound(src, 'sound/voice/merp.ogg', 35, 1)
	..()

/mob/living/simple_mob/animal/sif/sakimm/jil/proc/splat()
	src.health = 0
	src.set_stat(DEAD)
	src.icon_dead = "mouse_gray_splat"
	src.icon_state = "mouse_gray_splat"
	layer = MOB_LAYER
	if(client)
		client.time_died_as_mouse = world.time

// Jil noises
/datum/say_list/jil
	speak = list("Merp!","MERP!","Merp?")
	emote_hear = list("merps","mips","meeps")
	emote_see = list("runs in a circle", "shakes")



/*
	jil AI, just intentional sakimm AI, but without retaliation, and can pick up any small or tiny object
*/

/datum/ai_holder/simple_mob/intentional/sakimm/jil
	hostile = FALSE
	retaliate = TRUE // code doesn't allow targeting mobs, this is only so pickups still work, bluh at this hack
	vision_range = 10
	can_flee = TRUE
	flee_when_dying = TRUE

	greed = 5	// The probability we will try to steal something. Increases over time if we are not holding something, or wearing a hat.
	hoard_items = TRUE
	hoard_distance = 3	// How far an item can be from the Sakimm's home turf to be counted inside its 'hoard'.
	original_home_distance = null
	search_delay = 8 SECONDS	// How often can we look for item targets?
	last_search = 0

	base_wander_delay = 1
	max_home_distance = 850
	var/unreachable_locs = list()   //cleared when reaching nest/dropoff item, prevents window breaking spam

/datum/ai_holder/simple_mob/intentional/sakimm/jil/New()
	..()
	original_home_distance = max_home_distance
	last_search = world.time + rand( 0, search_delay) // randomize

/datum/ai_holder/simple_mob/intentional/sakimm/jil/post_melee_attack(atom/A)
	if(istype(A, /obj/item) && !holder.get_active_hand() && holder.Adjacent(A))
		// attempt grab
		var/obj/item/I = A
		I.attack_hand(holder)
		lose_target()
	if(!istype(A.loc,/turf))
		// oops, target is held by something else...
		greed = 0
		lose_target()

	// anything else loses target
	unreachable_locs += target.loc
	greed = 0
	lose_target()

/datum/ai_holder/simple_mob/intentional/sakimm/jil/list_targets()
	. = hearers(vision_range, holder) - holder

	var/static/hostile_machines = typecacheof(list(/obj/machinery/porta_turret, /obj/mecha))

	for(var/HM in typecache_filter_list(range(vision_range, holder), hostile_machines))
		if(can_see(holder, HM, vision_range))
			. += HM

	if(holder.get_active_hand())	// We don't want item targets if we have an item!
		return .

	if(world.time <= last_search + search_delay)	// Don't spam searching for item targets, since they can be in areas with a -lot- of items.
		return .

	for(var/obj/item/I in view(holder, vision_range))
		last_search = world.time
		if(!hoard_items || get_dist(I, home_turf) <= 1)
			continue
		if(!I.anchored && I.w_class <= ITEMSIZE_SMALL)
			. += I
			break

	. -= holder.contents

/datum/ai_holder/simple_mob/intentional/sakimm/jil/find_target(var/list/possible_targets, var/has_targets_list = FALSE)
	. = list()
	if(!has_targets_list)
		possible_targets = list_targets()

	for(var/possible_target in possible_targets)
		var/atom/A = possible_target
		var/forbid = FALSE
		
		for(var/forbid_loc in unreachable_locs) // forbidden item list
			if(A.loc == forbid_loc)
				forbid = TRUE
				break
		
		if(!istype(A, /mob/living) && can_attack(A) && (!forbid || A.loc == holder.loc))
			. += A
		
	for(var/obj/item/I in .)
		last_search = world.time
		if(!hoard_items || get_dist(I, home_turf) <= 1)
			. -= I

	var/new_target = pick_target(.)
	give_target(new_target)
	return new_target

/datum/ai_holder/simple_mob/intentional/sakimm/jil/pre_melee_attack(atom/A)
	if(istype(A, /obj/structure))
		// bonk
		holder.IMove(get_step(holder, pick(alldirs)))
		holder.a_intent = I_HELP
		greed = 0
		if(target)
			unreachable_locs += target.loc
		lose_target()
	else if(istype(A, /obj/item)) 
		var/obj/item/I = A
		if(istype(I, /obj/item/weapon/reagent_containers/food/snacks))	// If we can't pick it up, or it's edible, go to harm.
			holder.a_intent = I_HURT
		else
			holder.a_intent = I_HELP
			playsound(src, 'sound/voice/merp.ogg', 35, 1)

/datum/ai_holder/simple_mob/intentional/sakimm/jil/should_go_home()
	if((!returns_home && !holder.get_active_hand()) || !home_turf)	// If we have an item, we want to go home.
		return FALSE

	if(greed < 30 || get_dist(holder, home_turf) > max_home_distance)
		if(!home_low_priority)
			return TRUE
		else if(!leader && !target)
			return TRUE
	return FALSE

/datum/ai_holder/simple_mob/intentional/sakimm/jil/handle_special_tactic()
	var/mob/living/simple_mob/animal/sif/sakimm/jil/S = holder
	if(S.hat)
		hoard_items = FALSE
	else
		hoard_items = TRUE

	use_astar = FALSE // disable Astar most of the time, gives jils a dopey side for efficiency, but sometimes they just GOFORIT
	if(prob(50) || holder.get_active_hand())
		use_astar = TRUE // oh no no no
		if(prob(1)) 
			unreachable_locs = list() // clear list of ignore turfs when put in Astar mode (sometimes)

	


/datum/ai_holder/simple_mob/intentional/sakimm/jil/handle_special_strategical()
	var/mob/living/simple_mob/animal/sif/sakimm/jil/S = holder
	var/carrying_item = FALSE

	if(holder.get_active_hand())	// Do we have loot?
		if(istype(holder) && istype(holder.get_active_hand(), /obj/item/clothing/head) && !S.hat)
			var/obj/item/I = holder.get_active_hand()
			S.take_hat(S)
			holder.visible_message("<b>\The [holder]</b> wears \the [I]")
		carrying_item = TRUE

	if(istype(holder) && S.hat)		// Do we have a hat? Hats are loot.
		carrying_item = TRUE

	if(!carrying_item)	// Not carrying or wearing anything? We want to carry something more.
		if(prob(10)) greed++
		greed = min(95, greed)
	else
		greed = 0
	if(!target && prob(5 + greed) && !holder.get_active_hand())
		find_target()
	if(holder.get_active_hand() && hoard_items)
		lose_target()
		max_home_distance = 1
	if(get_dist(holder, home_turf) <= max_home_distance)
		holder.drop_from_inventory(holder.get_active_hand(), get_turf(holder))
		if(carrying_item)
			last_search = world.time
			unreachable_locs = list() // clear list of ignore turfs when item is return
	if(!holder.get_active_hand())
		max_home_distance = original_home_distance

/datum/ai_holder/simple_mob/intentional/sakimm/jil/special_flee_check()
	return holder.get_active_hand()

/datum/ai_holder/simple_mob/intentional/sakimm/jil/react_to_attack(atom/movable/attacker, ignore_timers = FALSE)
	// not allowed to retaliate!
	if(holder.stat) // We're dead.
		ai_log("react_to_attack() : Was attacked by [attacker], but we are dead/unconscious.", AI_LOG_TRACE)
		return FALSE
	else
		ai_log("react_to_attack() : Was attacked by [attacker], but we are not allowed to attack back.", AI_LOG_TRACE)
		return FALSE

/datum/ai_holder/simple_mob/intentional/sakimm/jil/give_up_movement()
	..()
	if(target)
		greed = 0
		unreachable_locs += target.loc
		lose_target()
	
	// truely lost, reset nest to here
	if(holder.get_active_hand() && holder.loc && home_turf && istype(holder.loc,/turf) && holder.loc.z != home_turf.z)
		home_turf = holder.loc