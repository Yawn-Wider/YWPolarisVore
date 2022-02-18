var/datum/planet/muriki/planet_muriki = null
//Dev note: This entire file handles weather and planetary effects. File name subject to change pending planet name finalization.
/datum/time/muriki
	seconds_in_day = 3 HOURS

/datum/planet/muriki
	name = "muriki"
	desc = "muriki is a TODO MAKE LORE HERE" // Ripped straight from the wiki.
	current_time = new /datum/time/muriki() // 42 hour
	// Outptostt21 - See the Defines for this, so that it can be edited there if needed.
	// expected_z_levels = list()
	planetary_wall_type = /turf/unsimulated/wall/planetary/borealis2 // TODO - replace with muriki turf

	sun_name = "SL-340"
	moon_name = ""

/datum/planet/muriki/New()
	..()
	planet_muriki = src
	weather_holder = new /datum/weather_holder/muriki(src) // Cold weather is also nice.

// This code is horrible.
/datum/planet/muriki/update_sun()
	..()
	var/datum/time/time = current_time
	var/length_of_day = time.seconds_in_day / 10 / 60 / 60
	var/noon = length_of_day / 2
	var/distance_from_noon = abs(text2num(time.show_time("hh")) - noon)
	sun_position = distance_from_noon / noon
	sun_position = abs(sun_position - 1)

	var/low_brightness = null
	var/high_brightness = null

	var/low_color = null
	var/high_color = null
	var/min = 0

	switch(sun_position)
		if(0 to 0.40) // Night
			low_brightness = 0.2
			low_color = "#660000"

			high_brightness = 0.5
			high_color = "#4D0000"
			min = 0

		if(0.40 to 0.50) // Twilight
			low_brightness = 0.6
			low_color = "#66004D"

			high_brightness = 0.8
			high_color = "#CC3300"
			min = 0.40

		if(0.50 to 0.70) // Sunrise/set
			low_brightness = 0.8
			low_color = "#DDDDDD"

			high_brightness = 0.9
			high_color = "#FFFFFF"
			min = 0.50

		if(0.70 to 1.00) // Noon
			low_brightness = 0.9
			low_color = "#CC3300"

			high_brightness = 1.0
			high_color = "#FF9933"
			min = 0.70

	var/interpolate_weight = (abs(min - sun_position)) * 4
	var/weather_light_modifier = 1
	if(weather_holder && weather_holder.current_weather)
		weather_light_modifier = weather_holder.current_weather.light_modifier

	var/new_brightness = (LERP(low_brightness, high_brightness, interpolate_weight) ) * weather_light_modifier

	var/new_color = null
	if(weather_holder && weather_holder.current_weather && weather_holder.current_weather.light_color)
		new_color = weather_holder.current_weather.light_color
	else
		var/list/low_color_list = hex2rgb(low_color)
		var/low_r = low_color_list[1]
		var/low_g = low_color_list[2]
		var/low_b = low_color_list[3]

		var/list/high_color_list = hex2rgb(high_color)
		var/high_r = high_color_list[1]
		var/high_g = high_color_list[2]
		var/high_b = high_color_list[3]

		var/new_r = LERP(low_r, high_r, interpolate_weight)
		var/new_g = LERP(low_g, high_g, interpolate_weight)
		var/new_b = LERP(low_b, high_b, interpolate_weight)

		new_color = rgb(new_r, new_g, new_b)

	spawn(1)
		update_sun_deferred(new_brightness, new_color)

// Returns the time datum of muriki.
/proc/get_muriki_time()
	if(planet_muriki)
		return planet_muriki.current_time

//Weather definitions
/datum/weather_holder/muriki
	temperature = 293.15 // 20c
	allowed_weather_types = list(
		WEATHER_OVERCAST	= new /datum/weather/muriki/acid_overcast(),
		WEATHER_RAIN        = new /datum/weather/muriki/acid_rain(),
		WEATHER_STORM		= new /datum/weather/muriki/acid_storm(),
		WEATHER_HAIL		= new /datum/weather/muriki/acid_hail()
		)
	roundstart_weather_chances = list(
		WEATHER_OVERCAST = 20,
		WEATHER_RAIN = 45,
		WEATHER_STORM = 30,
		WEATHER_HAIL = 5
		)

/datum/weather/muriki
	name = "muriki base"
	temp_high = 313.15	// 40c
	temp_low = 288.15	// 15c

/datum/weather/muriki/acid_overcast
	name = "fog"
	wind_high = 1
	wind_low = 0
	light_modifier = 0.7
	effect_message = "<span class='notice'>Acidic mist surrounds you.</span>"
	transition_chances = list(
		WEATHER_OVERCAST = 80,
		WEATHER_RAIN = 15,
		WEATHER_HAIL = 5
		)
	observed_message = "It is misting, all you can see are corrosive clouds."
	transition_messages = list(
		"All you can see is fog.",
		"Fog cuts off your view.",
		"It's very foggy."
		)

	outdoor_sounds_type = /datum/looping_sound/weather/wind/gentle
	indoor_sounds_type = /datum/looping_sound/weather/wind/gentle/indoors

/datum/weather/muriki/acid_overcast/process_effects()
	..()
	for(var/mob/living/L as anything in living_mob_list)
		if(L.z in holder.our_planet.expected_z_levels)
			var/turf/T = get_turf(L)
			if(!T.is_outdoors())
				continue // They're indoors, so no need to rain on them.

			// show transition messages
			if(show_message)
				to_chat(L, effect_message)

			// digest living things
			var/mob/living/carbon/human/H = L
			if(istype(H))
				process_complex_mob_burns(H,1)
			else
				process_acid_burning(L,1,TRUE)


/datum/weather/muriki/acid_rain
	name = "rain"
	icon_state = "rain"
	temp_high = 293.15 // 20c
	temp_low = T0C
	wind_high = 2
	wind_low = 1
	light_modifier = 0.5
	effect_message = "<span class='notice'>Acidic rain falls on you.</span>"

	transition_chances = list(
		WEATHER_OVERCAST = 25,
		WEATHER_RAIN = 50,
		WEATHER_STORM = 10,
		WEATHER_HAIL = 15
		)
	observed_message = "It is raining."
	transition_messages = list(
		"The sky is dark, and acidic rain falls down upon you."
	)
	outdoor_sounds_type = /datum/looping_sound/weather/rain
	indoor_sounds_type = /datum/looping_sound/weather/rain/indoors

/datum/weather/muriki/acid_rain/process_effects()
	..()
	for(var/mob/living/L as anything in living_mob_list)
		if(L.z in holder.our_planet.expected_z_levels)
			var/turf/T = get_turf(L)
			if(L.stat >= DEAD || !T.is_outdoors())
				continue // They're indoors or dead, so no need to rain on them.

			// If they have an open umbrella, it'll guard from rain
			var/obj/item/weapon/melee/umbrella/U = L.get_active_hand()
			if(!istype(U) || !U.open)
				U = L.get_inactive_hand()

			if(istype(U) && U.open)
				if(show_message)
					to_chat(L, "<span class='notice'>Rain showers loudly onto your umbrella!</span>")
				continue

			// show transition messages
			if(show_message)
				to_chat(L, effect_message)

			// digest living things
			var/mob/living/carbon/human/H = L
			if(istype(H))
				process_complex_mob_burns(H,0)
			else
				process_acid_burning(L,1,TRUE)


/datum/weather/muriki/acid_storm
	name = "storm"
	icon_state = "storm"
	temp_high = T0C
	temp_low =  268.15 // -5c
	wind_high = 4
	wind_low = 2
	light_modifier = 0.3
	flight_failure_modifier = 10
	effect_message = "<span class='notice'>Acidic rain falls on you.</span>"

	var/next_lightning_strike = 0 // world.time when lightning will strike.
	var/min_lightning_cooldown = 5 SECONDS
	var/max_lightning_cooldown = 1 MINUTE
	observed_message = "An intense storm pours down over the region."
	transition_messages = list(
		"You feel intense winds hit you as the weather takes a turn for the worst.",
		"Loud thunder is heard in the distance.",
		"A bright flash heralds the approach of a storm."
	)
	outdoor_sounds_type = /datum/looping_sound/weather/rain/heavy
	indoor_sounds_type = /datum/looping_sound/weather/rain/heavy/indoors


	transition_chances = list(
		WEATHER_RAIN = 45,
		WEATHER_STORM = 40,
		WEATHER_HAIL = 10,
		WEATHER_OVERCAST = 5
		)

/datum/weather/muriki/acid_storm/process_effects()
	..()
	for(var/mob/living/L as anything in living_mob_list)
		if(L.z in holder.our_planet.expected_z_levels)
			var/turf/T = get_turf(L)
			if(L.stat >= DEAD || !T.is_outdoors())
				continue // They're indoors or dead, so no need to rain on them.

			// If they have an open umbrella, it'll guard from rain
			var/obj/item/weapon/melee/umbrella/U = L.get_active_hand()
			if(!istype(U) || !U.open)
				U = L.get_inactive_hand()

			if(istype(U) && U.open)
				if(show_message)
					to_chat(L, "<span class='notice'>Rain showers loudly onto your umbrella!</span>")
				continue

			// show transition messages
			if(show_message)
				to_chat(L, effect_message)

			// digest living things
			var/mob/living/carbon/human/H = L
			if(istype(H))
				process_complex_mob_burns(H,0)
			else
				process_acid_burning(L,1,TRUE)
	handle_lightning()


// This gets called to do lightning periodically.
// There is a seperate function to do the actual lightning strike, so that badmins can play with it.
/datum/weather/muriki/acid_storm/proc/handle_lightning()
	if(world.time < next_lightning_strike)
		return // It's too soon to strike again.
	next_lightning_strike = world.time + rand(min_lightning_cooldown, max_lightning_cooldown)
	var/turf/T = pick(holder.our_planet.planet_floors) // This has the chance to 'strike' the sky, but that might be a good thing, to scare reckless pilots.
	lightning_strike(T)

/datum/weather/muriki/acid_hail
	name = "hail"
	icon_state = "hail"
	temp_high = 263.15  // -10c
	temp_low = 253.15	// -20c
	light_modifier = 0.3
	flight_failure_modifier = 15
	timer_low_bound = 2
	timer_high_bound = 5
	effect_message = "<span class='warning'>The hail smacks into you!</span>"

	transition_chances = list(
		WEATHER_RAIN = 45,
		WEATHER_STORM = 40,
		WEATHER_HAIL = 10,
		WEATHER_OVERCAST = 5
		)
	observed_message = "Frozen acid is falling from the sky."
	transition_messages = list(
		"Frozen acid begins to fall from the sky.",
		"It begins to hail.",
		"An intense chill is felt, and chunks of frozen acid start to fall from the sky, towards you."
	)

/datum/weather/muriki/acid_hail/process_effects()
	..()
	for(var/mob/living/carbon/L as anything in human_mob_list)
		if(L.z in holder.our_planet.expected_z_levels)
			var/turf/T = get_turf(L)
			if(L.stat >= DEAD || !T.is_outdoors())
				continue // They're indoors or dead, so no need to pelt them with ice.

			// If they have an open umbrella, it'll guard from hail
			var/obj/item/weapon/melee/umbrella/U = L.get_active_hand()
			if(!istype(U) || !U.open)
				U = L.get_inactive_hand()

			if(istype(U) && U.open)
				if(show_message)
					to_chat(L, "<span class='notice'>Hail patters onto your umbrella.</span>")
				continue

			var/target_zone = pick(BP_ALL)
			var/amount_blocked = L.run_armor_check(target_zone, "melee")
			var/amount_soaked = L.get_armor_soak(target_zone, "melee")

			var/damage = rand(1,3)

			if(amount_blocked >= 30)
				continue // No need to apply damage. Hardhats are 30. They should probably protect you from hail on your head.
				//Voidsuits are likewise 40, and riot, 80. Clothes are all less than 30.

			if(amount_soaked >= damage)
				continue // No need to apply damage.
			L.apply_damage(damage, BRUTE, target_zone, amount_blocked, amount_soaked, used_weapon = "hail")

			// show transition messages
			if(show_message)
				to_chat(L, effect_message)


/proc/process_acid_burning( var/mob/living/L, var/multiplier, var/wildlife)
	// drop out early if no damage anyway
	if(multiplier <= 0)
		return
	
	// TODO
	// check for excluded creatures, if being called as wildlife damage
	//if(wildlife == TRUE)
		// stuff like jils here
		// return
		
	// burn!
	L.burn_skin(0.25 * multiplier)


/proc/process_complex_mob_burns( var/mob/living/carbon/human/H, var/mist)
	//Burn eyes, lungs and skin if exposed.
	var/burn_eyes = mist
	var/burn_lungs = mist


	//Check for protective glasses
	if(H.glasses && (H.glasses.body_parts_covered & EYES) && (H.glasses.item_flags & AIRTIGHT))
		burn_eyes = 0
	if(H.glasses && H.glasses.item_flags & AIRTIGHT)
		burn_lungs = 0

	//Check for protective maskwear
	if(burn_eyes && H.wear_mask && (H.wear_mask.body_parts_covered & EYES) && (H.wear_mask.item_flags & AIRTIGHT))
		burn_eyes = 0
	if(burn_lungs && H.wear_mask.item_flags & AIRTIGHT)
		burn_lungs = 0

	//Check for protective helmets
	if(burn_eyes && H.head && (H.head.body_parts_covered & EYES) && (H.head.item_flags & AIRTIGHT))
		burn_eyes = 0
	if(burn_lungs && H.head.item_flags & AIRTIGHT)
		burn_lungs = 0

	//VOREStation Edit - NIF Support
	if(H.nif && H.nif.flag_check(NIF_V_UVFILTER,NIF_FLAGS_VISION))
		burn_eyes = 0


	//burn their eyes!
	if(burn_eyes)
		var/obj/item/organ/internal/eyes/O = H.internal_organs_by_name[O_EYES]
		if(O && prob(20)) 
			O.damage += 1.5
			to_chat(H,  "<span class='danger'>Your eyes burn!</span>")
	
	//burn their lungs!
	if(burn_lungs)
		var/obj/item/organ/internal/lungs/O = H.internal_organs_by_name[O_LUNGS]
		if(O && prob(20)) 
			O.damage += 1.5
			to_chat(H,  "<span class='danger'>Your lungs burn!</span>")

	// randomly burn their skin in exposed areas!
	var/min_permeability = 0.10;
	if(prob(25) && H.reagent_permeability() > min_permeability)
		// control damage done
		var/acid_multiplier = 1
		
		// unfortunately, the area burning code someone else was working on is a lie, and the thermal damage done is simply based on the collective insulation of your clothing....
		// so effectively, all the damage is random, unless I make some homebrew damage function for each limb instead of using the burn_skin() proc... 
		// Which I'd rather not complicate this code base any more than it is... So lets just take permeability into account instead and scale it.
		// damage to the part is modified by what protection it has, full if none
		// also no check for gloves because they seem to almost always be highly permeable...
		var/obj/item/protection = pickweight( list(H.wear_suit, H.shoes, H.head))
		if(protection == null)
			// full damage, what are you doing!?
			acid_multiplier = 1
			to_chat(H, "<span class='danger'>The acidic environment burns your exposed skin!</span>")
		else if(protection.permeability_coefficient > min_permeability)
			// only show the message if the permeability selection actually did any damage at all
			acid_multiplier = protection.permeability_coefficient 
			to_chat(H, "<span class='danger'>The acidic environment leaks through your clothing and burns your skin!</span>")
		else
			// nothing shows up, no damage!
			acid_multiplier = 0
		
		// apply acid damage
		process_acid_burning(H, acid_multiplier,FALSE)

		
		