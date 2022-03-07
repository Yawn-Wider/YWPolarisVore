/datum/category_item/catalogue/fauna/sakimm/jil
	name = "Jil"
	desc = ""
	value = CATALOGUER_REWARD_EASY

/mob/living/simple_mob/animal/sif/sakimm/jil/jillilah
	..()
	name = "jillilah"
	real_name = "jillilah"
	desc = "When you stare deep in her beady little eyes, you can feel an intense desire to declare independence..."

	faction = "cargonia"
	randomize_size = FALSE

/mob/living/simple_mob/animal/sif/sakimm/jil
	name = "jil"
	real_name = "jil"
	desc = "It's a small rodent."
	tt_desc = "E Mus musculus"
	icon = 'icons/mob/animal_op.dmi'
	icon_state = "jil"
	item_state = "jil"
	icon_living = "jil"
	icon_dead = "jil_dead"
	kitchen_tag = "rodent"

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
	randomize_size = TRUE // unit jil sizes
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
	src.icon_dead = "jil_splat"
	src.icon_state = "jil_splat"
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
	use_astar = TRUE // oh no no no

	greed = 5	// The probability we will try to steal something. Increases over time if we are not holding something
	hoard_items = TRUE
	hoard_distance = 3	// How far an item can be from the Sakimm's home turf to be counted inside its 'hoard'.
	original_home_distance = null
	search_delay = 8 SECONDS	// How often can we look for item targets?
	last_search = 0

	base_wander_delay = 1
	max_home_distance = 850
	var/unreachable_locs = list()   //cleared when reaching nest/dropoff item, prevents window breaking spam
	var/forbidden_objs = list(/obj/item/weapon/deck,/obj/item/weapon/paper_bin,/obj/item/stack) // things that don't play well with jils


/datum/ai_holder/simple_mob/intentional/sakimm/jil/New()
	..()
	hoard_items = !istype(holder,/mob/living/simple_mob/animal/sif/sakimm/jil/jillilah) // jillilah disables hoarding

	original_home_distance = max_home_distance
	last_search = world.time + rand( 0, search_delay) // randomize


/datum/ai_holder/simple_mob/intentional/sakimm/jil/pre_melee_attack(atom/A)
	if(istype(A, /obj/item)) 
		var/obj/item/I = A
		if(istype(I, /obj/item/weapon/reagent_containers/food/snacks))	// If we can't pick it up, or it's edible, go to harm.
			holder.a_intent = I_HURT
		else
			holder.a_intent = I_HELP
	else
		// bonk for all others
		holder.a_intent = I_HELP

		// this is stupid, always set to 5 so it fails at first window bump
		failed_breakthroughs = 5

		// forbid target if not item
		forget_target_and_avoid()

		// the SOUND
		holder.visible_message("<font color='blue'>[bicon(src)] Merp!</font>")
		playsound(src, 'sound/voice/merp.ogg', 35, 1)


/datum/ai_holder/simple_mob/intentional/sakimm/jil/post_melee_attack(atom/A)
	if(istype(A, /obj/item) && !holder.get_active_hand() && holder.Adjacent(A))
		// attempt grab of target!
		var/obj/item/I = A
		I.attack_hand(holder)
	else if(istype(A, /obj/structure/closet))
		// attempt to open!
		var/obj/structure/closet/C = A
		if(!C.opened && C.can_open())
			C.attack_hand(holder)
	/*
	else if(istype(A,/obj/machinery/atmospherics/unary/vent_pump) || istype(A,/obj/machinery/atmospherics/unary/vent_scrubber))
		// vent crawl
		holder.ventcrawl()
	*/


/datum/ai_holder/simple_mob/intentional/sakimm/jil/list_targets()
	. = hearers(vision_range, holder) - holder
	if(!hoard_items)
		return

	var/static/hostile_machines = typecacheof(list(/obj/machinery/porta_turret, /obj/mecha))
	for(var/HM in typecache_filter_list(range(vision_range, holder), hostile_machines))
		if(can_see(holder, HM, vision_range))
			. += HM

	if(holder.get_active_hand())	// We don't want item targets if we have an item!
		return .

	if(world.time <= last_search + search_delay)	// Don't spam searching for item targets, since they can be in areas with a -lot- of items.
		return .
	last_search = world.time

	for(var/atom/A in view(holder, vision_range))
		if(get_dist(A, home_turf) < hoard_distance)
			continue

		// collect items!
		if(istype(A,/obj/item))
			var/obj/item/I = A
			if(!I.anchored && I.w_class <= ITEMSIZE_NORMAL) // jils are large enough to...
				. += I
				break
		// bonus interactions!
		else if(istype(A,/obj/structure/closet)) // opening closets
			var/obj/structure/closet/C = A
			if(!C.opened && C.can_open())
				. += C
			else
				// update targets!
				find_target()
		/*
		else if(istype(A,/obj/machinery/atmospherics/unary/vent_pump)) // entering vents
			var/obj/machinery/atmospherics/unary/vent_pump/P = A
			if(prob(5)) // only sometimes
				. += P
		else if(istype(A,/obj/machinery/atmospherics/unary/vent_scrubber)) // entering vents
			var/obj/machinery/atmospherics/unary/vent_scrubber/S = A
			if(prob(5)) // only sometimes
				. += S
		*/
	. -= holder.contents


/datum/ai_holder/simple_mob/intentional/sakimm/jil/proc/forget_target_and_avoid()
	// lose target and add it to excluded
	if(target && istype(target.loc, /turf)) 
		unreachable_locs += target.loc // if not inside something!
	lose_target()


/datum/ai_holder/simple_mob/intentional/sakimm/jil/find_target(var/list/possible_targets, var/has_targets_list = FALSE)
	if(!hoard_items)
		return
	
	if(holder.is_ventcrawling)
		return

	. = list()
	if(!has_targets_list)
		possible_targets = list_targets()

	for(var/possible_target in possible_targets)
		var/atom/A = possible_target
		var/forbid = FALSE
		
		for(var/forbid_loc in unreachable_locs) // forbidden turf list
			if(A.loc == forbid_loc)
				forbid = TRUE
				break

		for(var/forbid_obj in forbidden_objs) // forbidden object list
			if(istype(A,forbid_obj))
				forbid = TRUE
				break
			
		
		if(!istype(A, /mob/living) && can_attack(A) && !forbid)
			. += A
		
	for(var/obj/item/I in .)
		last_search = world.time
		if(!hoard_items || get_dist(I, home_turf) < hoard_distance)
			. -= I

	var/new_target = pick_target(.)
	give_target(new_target)
	return new_target
		

/datum/ai_holder/simple_mob/intentional/sakimm/jil/should_go_home()
	if(!hoard_items)
		return TRUE

	if(holder.is_ventcrawling)
		return FALSE

	if(holder.health < holder.maxHealth) // HP FEAR
		return TRUE

	if((!returns_home && !holder.get_active_hand()) || !home_turf)	// If we have an item, we want to go home.
		return FALSE

	if(get_dist(holder, home_turf) > max_home_distance)
		if(!home_low_priority)
			return TRUE
		else if(!leader && !target)
			return TRUE
	return FALSE


/datum/ai_holder/simple_mob/intentional/sakimm/jil/handle_special_strategical()
	// nothing special if not a hoarder
	if(!hoard_items)
		return

	// vent crawler handling
	if(holder.is_ventcrawling)
		return

	// too far from old nest? Find an item and make it the new nest
	if(holder.get_active_hand() && prob(10))
		if(holder.loc && home_turf && istype(holder.loc,/turf) && (get_dist(holder.loc, home_turf) > 30 || holder.loc.z != home_turf.z))
			home_turf = holder.loc

	// clear old forbid turf
	if(prob(2))
		for(var/turf/forbid_loc in unreachable_locs) // forbidden turf list
			if(get_dist(holder.loc, forbid_loc) < 2)
				unreachable_locs -= forbid_loc // remove from list, enough to step to
			else if(get_dist(holder.loc, forbid_loc) > 30)
				unreachable_locs -= forbid_loc // remove from list, far enough to forget
			else if(prob(5))
				unreachable_locs -= forbid_loc // random retry

	// not holding something, get greedier, find way to target
	if(!holder.get_active_hand() && holder.health == holder.maxHealth)
		// oops, target is held by something else...
		if(target && !istype(target.loc,/turf))
			forget_target_and_avoid()
			greed = 100 // REALLY WANT A NEW TARGET

		// find targets
		if(prob(10)) 
			greed++
		greed = min(95, greed)
		if(!target && prob(5 + greed) && !holder.get_active_hand())
			find_target()
	else
		// return to nest! Lose all targets
		if(target)
			holder.visible_message("<font color='blue'>[bicon(src)] Merp!</font>")
			playsound(src, 'sound/voice/merp.ogg', 35, 1)
			forget_target_and_avoid()

		// return home
		if(holder.health < holder.maxHealth || (holder.get_active_hand() && hoard_items))
			max_home_distance = 1

		if(get_dist(holder, home_turf) <= max_home_distance)
			// drop item off at nest
			if(holder.get_active_hand())
				last_search = world.time
				greed = 0
				holder.drop_from_inventory(holder.get_active_hand(), get_turf(holder))

		if(holder.health == holder.maxHealth && !holder.get_active_hand())
			max_home_distance = original_home_distance


/datum/ai_holder/simple_mob/intentional/sakimm/jil/special_flee_check()
	return holder.get_active_hand()
	

/datum/ai_holder/simple_mob/intentional/sakimm/jil/react_to_attack(atom/movable/attacker, ignore_timers = FALSE)
	if(holder.is_ventcrawling)
		return FALSE

	// not allowed to retaliate!
	if(holder.stat) // We're dead.
		ai_log("react_to_attack() : Was attacked by [attacker], but we are dead/unconscious.", AI_LOG_TRACE)
		return FALSE
	else
		ai_log("react_to_attack() : Was attacked by [attacker], but we are not allowed to attack back.", AI_LOG_TRACE)
		holder.visible_message("<font color='blue'>[bicon(src)] Merp!</font>")
		playsound(src, 'sound/voice/merp.ogg', 35, 1)
		forget_target_and_avoid() // give up on items
		return FALSE