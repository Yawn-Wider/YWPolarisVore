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
	var/icon_sleep = "jil_sleep"
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
			bonk(AM)
	..()

/mob/living/simple_mob/animal/sif/sakimm/jil/proc/splat()
	src.health = 0
	src.set_stat(DEAD)
	src.icon_dead = "jil_splat"
	src.icon_state = "jil_splat"
	layer = MOB_LAYER
	if(client)
		client.time_died_as_mouse = world.time

/mob/living/simple_mob/animal/sif/sakimm/jil/proc/bonk(var/mob/M)
	// bonk noise
	M.visible_message("<font color='blue'>[bicon(src)] Merp!</font>")
	playsound(src, 'sound/voice/merp.ogg', 35, 1)

/mob/living/simple_mob/animal/sif/sakimm/jil/Life()
	..()
	if(stat != DEAD)
		// adjust sleep here, needs mind to sleep otherwise...
		// adding the check so this doesn't conflict with life/handle_regular_status_updates()
		if(sleeping > 0 && (!mind || !mind.active || client == null))
			AdjustSleeping(-1)

		// sleep animate
		if(stat == UNCONSCIOUS || sleeping > 0)
			icon_state = icon_sleep
			item_state = icon_sleep
		else
			icon_state = icon_living
			item_state = icon_living

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

	intelligence_level = AI_DUMB // giveup easy
	var/home_turf_previous = null // if old hometurf exists and we're in range of it, reset home to it! 
	var/home_turf_original = null // 

	base_wander_delay = 1
	max_home_distance = 850
	var/unreachable_locs = list()   //cleared when reaching nest/dropoff item, prevents window breaking spam
	var/forbidden_objs = list(/obj/item/weapon/deck,/obj/item/weapon/paper_bin,/obj/item/stack) // things that don't play well with jils
	var/last_pickup_turf = null // when a jil return an item to the nest, this turf is removed from the forbid, so lockers work better

/datum/ai_holder/simple_mob/intentional/sakimm/jil/New()
	..()
	// search setup
	original_home_distance = max_home_distance
	search_delay = rand(5,9) SECONDS	// How often can we look for item targets?
	last_search = world.time + rand( 0, search_delay) // randomize

	// set first home
	home_turf_original = home_turf


/datum/ai_holder/simple_mob/intentional/sakimm/jil/proc/set_new_home(atom/A)
	if(holder.loc && istype(A,/turf))
		// if first home away from home... then our origin_home can be set!
		home_turf_previous = home_turf
		home_turf = A // new nest!
		last_pickup_turf = null // clear


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
		var/mob/living/simple_mob/animal/sif/sakimm/jil/J = holder
		J.bonk(holder)

	// this is stupid, always set to 5 so it fails at first window bump
	failed_breakthroughs = 4

	// if not a closet...
	if(!istype(A, /obj/structure/closet)) 
		// forbid turf, we picked it up or couldn't reach it
		if(target && istype(target.loc, /turf)) 
			unreachable_locs += target.loc // if not inside something!

	// check if we should make a new nest due to being trapped!
	if(prob(30) && max_home_distance == 1)
		set_new_home(holder.loc)

	// end path to target
	if(target && istype(target.loc, /turf)) 
		last_pickup_turf = target.loc // for closet fix
	give_up_movement()
	lose_target()
	

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
		if(!istype(A, /obj/item/weapon/reagent_containers/food/snacks) && get_dist(A, home_turf) < hoard_distance)
			// disable for things already in hoard, food needs to be eaten though
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
	if(holder.stat == DEAD)
		return

	// nothing special if not a hoarder
	if(!hoard_items)
		return

	// vent crawler handling
	if(holder.is_ventcrawling)
		return

	// rejuvinate nest!
	if(home_turf_previous) 
		// reset to last home
		if(get_dist(holder.loc, home_turf_previous) < 2)
			home_turf = home_turf_previous
			home_turf_previous = null
	if(home_turf_original) 
		// reset to origin home, all other homes give up
		if(home_turf_original && get_dist(holder.loc, home_turf_original) < 2) 
			home_turf = home_turf_original
			home_turf_previous = null

	// too far from old nest? Find an item and make it the new nest
	if(holder.get_active_hand() && holder.loc && home_turf && istype(holder.loc,/turf) && (get_dist(holder.loc, home_turf) > 20 || holder.loc.z != home_turf.z))
		home_turf_previous = home_turf
		home_turf = holder.loc // new nest!

	// disable Astar most of the time, gives jils a dopey side for efficiency, but sometimes they just GOFORIT
	use_astar = FALSE 
	if(prob(30) || holder.get_active_hand())
		use_astar = TRUE // oh no no no

	// clear old forbid turf
	if(prob(10))
		for(var/turf/forbid_loc in unreachable_locs) // forbidden turf list
			if(get_dist(holder.loc, forbid_loc) < 2)
				unreachable_locs -= forbid_loc // remove from list, enough to step to
			else if(get_dist(holder.loc, forbid_loc) > 30)
				unreachable_locs -= forbid_loc // remove from list, far enough to forget
			else if(prob(2))
				unreachable_locs -= forbid_loc // random retry

	// not holding something, get greedier, find way to target
	if(!holder.get_active_hand() && holder.health == holder.maxHealth && holder.sleeping <= 0)
		// oops, target is held by something else...
		if(target && !istype(target.loc,/turf))
			// lose target... 
			if(target && istype(target.loc, /turf)) 
				unreachable_locs += target.loc // if not inside something!
			give_up_movement()
			lose_target()
			last_pickup_turf = null
			greed = 100 // REALLY WANT A NEW TARGET

		// wander from nest
		max_home_distance = original_home_distance

		// find targets
		if(prob(10)) 
			greed++
		greed = min(95, greed)
		if(!target && prob(5 + greed))
			last_pickup_turf = null // new target, new cleanup turf
			find_target()
	else
		// clean target
		if(target)
			lose_target()

		// return home
		max_home_distance = hoard_distance-1
		if(get_dist(holder, home_turf) <= max_home_distance || holder.sleeping > 0)
			// drop item off at nest
			if(holder.get_active_hand())
				last_search = world.time
				greed = 0
				holder.drop_from_inventory(holder.get_active_hand(), get_turf(holder))
				if(last_pickup_turf)
					unreachable_locs -= last_pickup_turf // remove from list, far enough to forget
					last_pickup_turf = null // clear last pickup, we freaked out

			if(holder.sleeping > 0 || holder.health < holder.maxHealth || prob(15))
				var/mob/living/simple_mob/animal/sif/sakimm/jil/J = holder
				if(J.sleeping <= 0)
					J.Sleeping(50 + rand(100)) // why is this proc capitalized...
					J.health += 1 // heal!
					if(J.health > J.maxHealth)
						J.health = J.maxHealth
				// quick update...
				J.icon_state = J.icon_sleep
				J.item_state = J.icon_sleep
			


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
		var/mob/living/simple_mob/animal/sif/sakimm/jil/J = holder
		J.bonk(attacker)
		if(target)
			// lose target... 
			if(target && istype(target.loc, /turf)) 
				unreachable_locs += target.loc // if not inside something!
			if(holder.get_active_hand())
				holder.drop_from_inventory(holder.get_active_hand(), get_turf(holder))
			last_pickup_turf = null // clear last pickup, we freaked out
			give_up_movement()
			lose_target()
		return FALSE

	