
#define SHIELD_GAUNTLET_ICON 'code/modules/yw-halo/weapons/covenant/shield_gauntlet.dmi'
#define SHIELD_GAUNTLET_ICON_INHAND_L 'code/modules/yw-halo/weapons/covenant/shield_gauntlet_lefthand.dmi'
#define SHIELD_GAUNTLET_ICON_INHAND_R 'code/modules/yw-halo/weapons/covenant/shield_gauntlet_righthand.dmi'
#define GAUNTLET_WARNING_DELAY 2 SECONDS

/obj/item/clothing/gloves/shield_gauntlet
	name = "Shield Gauntlet"
	desc = "Shield Gauntlet"

	icon = SHIELD_GAUNTLET_ICON
	icon_state = "gauntlet"

	action_button_name = "Toggle Shield Gauntlet"

	var/shield_max_charge = 380
	var/shield_current_charge = 380
	var/list/shield_colour_values = list("#0000FF","#00FFFF","#FFFF00","#FFA500","#FF2600")		//highest charge to lowest charge
	var/shield_recharge_delay = 6 SECONDS //The delay between taking damage and starting to recharge, in ticks.
	var/shield_next_charge
	var/active_slowdown_amount = 0.8 //Bracing to hide behind the shield.
	var/overloaded = 0

	var/obj/item/weapon/gauntlet_shield/connected_shield
	matter = list("nanolaminate" = 1)
	var/time_next_warning = 0

/obj/item/clothing/gloves/shield_gauntlet/examine(var/mob/user)
	. = ..()
	if(overloaded)
		to_chat(user, "\icon[src] <span class='warning'>[src] has been overloaded and cannot be used for another \
			[(shield_next_charge - world.time)/10] seconds.</span>")
	else
		var/span_class = "info"
		if(shield_current_charge < shield_max_charge * 0.33)
			span_class = "danger"
		else if(shield_current_charge < shield_max_charge * 0.66)
			span_class = "warning"
		to_chat(user, "<span class='[span_class]'>It has [shield_charge_string()].</span>")

/obj/item/clothing/gloves/shield_gauntlet/proc/shield_charge_string()
	return "[shield_current_charge]/[shield_max_charge] charge ([shield_percent_string()])"

/obj/item/clothing/gloves/shield_gauntlet/proc/shield_percent_string()
	var/percent = round(100 * shield_current_charge/shield_max_charge)
	if(shield_current_charge > 0 && !percent)
		percent = 1
	return "[percent]%"

/obj/item/clothing/gloves/shield_gauntlet/attack_self(var/mob/living/carbon/human/user)
	if(connected_shield)
		deactivate()

	else if(overloaded)
		to_chat(user, "\icon[src] <span class='warning'>[src] has been overloaded and cannot be used for another \
			[(shield_next_charge - world.time)/10] seconds.</span>")
		return

	else if(user.gloves != src)
		to_chat(user, "\icon[src] <span class='notice'>You must be wearing [src] on your hands to activate it.</span>")

	else if(!try_activate())
		return

	to_chat(user, "\icon[connected_shield ? connected_shield : src] <span class='info'>You [connected_shield ? "en" : "dis"]able [src].</span>")
	update_icon()

/obj/item/clothing/gloves/shield_gauntlet/proc/try_activate()
	var/mob/user = src.loc
	if(istype(user))
		connected_shield = new(user, src)
		connected_shield.slowdown_general = active_slowdown_amount
		if(!user.put_in_inactive_hand(connected_shield))
			if(!user.put_in_active_hand(connected_shield))
				qdel(connected_shield)
				to_chat(user,"<span class = 'notice'>You need one hand free to use [src].</span>")
				return 0
		set_light(2,1)
		update_icon()
		return 1

/obj/item/clothing/gloves/shield_gauntlet/proc/overload()

	//disable the inhand shield
	deactivate()

	//reactivate as soon as our timer is up
	overloaded = 1

	//reactivate with some bonus shield charge
	shield_current_charge = shield_max_charge / 2

/obj/item/clothing/gloves/shield_gauntlet/proc/hand_dropped()
	//just annul it
	connected_shield = null
	update_icon()
	set_light(0,0)

/obj/item/clothing/gloves/shield_gauntlet/proc/deactivate()
	if(connected_shield)
		var/mob/user = connected_shield.loc
		if(istype(user))
			user.drop_from_inventory(connected_shield)
		else
			qdel(connected_shield)
			message_admins("WARNING: JACKAL SHIELD GAUNTLET at [user] failed to deactivate() properly")

/obj/item/clothing/gloves/shield_gauntlet/dropped(var/mob/user)
	deactivate()

/obj/item/clothing/gloves/shield_gauntlet/handle_shield(mob/user, var/damage, atom/damage_source = null, var/mob/attacker = null, var/def_zone = null, var/attack_text = "the attack")

	//which turf did the attack come in from?
	var/turf/starting
	var/obj/item/projectile/P = damage_source
	if(istype(P))
		starting = get_turf(P)
		damage = max(0,damage + P.shield_damage)
	else
		starting = get_turf(damage_source)

	//was it from our blind spot?
	if(!(get_dir(src, starting) in get_blocked_attack_dirs()))
		return 0

	//did our shield absorb the shot?
	if(drain_shield(damage))
		if(istype(P, /obj/item/projectile))
			P.on_impact(src)
		//put a chatlog delay on warning the user
		if(world.time >= time_next_warning)
			time_next_warning = world.time + GAUNTLET_WARNING_DELAY
			if(istype(attacker))
				to_chat(user,"<span class = 'warning'>[attacker]'s attack is absorbed by the [src].</span>")
			else
				to_chat(user,"<span class = 'warning'>[damage_source] is absorbed by the [src].</span>")
		return -1

	return 0

/obj/item/clothing/gloves/shield_gauntlet/proc/get_blocked_attack_dirs()
	return list(loc.dir,turn(loc.dir,45),turn(loc.dir,-45))
	/*
	switch(loc.dir)
		if(NORTH)
			allowed_attack_dirs = list(SOUTH,,SOUTHWEST)
		if(SOUTH)
			allowed_attack_dirs = list(NORTH,NORTHEAST,NORTHWEST)
		if(EAST)
			allowed_attack_dirs = list(WEST,NORTHWEST,SOUTHWEST)
		if(WEST)
			allowed_attack_dirs = list(EAST,NORTHEAST,SOUTHEAST)

	return allowed_attack_dirs*/

/obj/item/clothing/gloves/shield_gauntlet/proc/drain_shield(var/damage)
	if(connected_shield)

		//set a delay on recharging
		if(!shield_next_charge)
			GLOB.processing_objects |= src
		shield_next_charge = world.time + shield_recharge_delay

		//subtract the damage
		shield_current_charge -= damage

		//overloaded from damage?
		if(shield_current_charge < 0)
			shield_current_charge = 0
			overloaded = 1
			deactivate()
			visible_message("<span class = 'danger'>[src.loc]'s [src] fails, overloading the shield projector.</span>")

			//double the normal recharge time
			shield_next_charge += shield_recharge_delay

		update_icon()

		return 1

	return 0

/obj/item/clothing/gloves/shield_gauntlet/update_icon()
	if(connected_shield)
		//our gauntlets are active
		icon_state = "gauntlet_active"

		//work out which damage indicator we are at
		//deep blue -> light blue -> yellow -> orange -> red
		var/shield_colour
		if(shield_current_charge < 1 * shield_max_charge / 5)
			shield_colour = shield_colour_values[5]
		else if(shield_current_charge < 2 * shield_max_charge / 5)
			shield_colour = shield_colour_values[4]
		else if(shield_current_charge < 3 * shield_max_charge / 5)
			shield_colour = shield_colour_values[3]
		else if(shield_current_charge < 4 * shield_max_charge / 5)
			shield_colour = shield_colour_values[2]
		else
			shield_colour = shield_colour_values[1]

		//set the inhand shield colour
		connected_shield.color = shield_colour

		var/mob/living/user = src.loc
		if(istype(user))
			if(user.l_hand == connected_shield)
				user.update_inv_l_hand()
			else if(user.r_hand == connected_shield)
				user.update_inv_r_hand()

	else if(overloaded)
		icon_state = "gauntlet_overloaded"
	else
		icon_state = "gauntlet"

	update_action_icon()

/obj/item/clothing/gloves/shield_gauntlet/proc/update_action_icon()
	action.button.UpdateIcon()
	if(connected_shield)
		action.button.maptext = "[shield_percent_string()]"
	else
		action.button.maptext = null

/obj/item/clothing/gloves/shield_gauntlet/process()
	if(shield_current_charge >= shield_max_charge)
		GLOB.processing_objects -= src
		shield_next_charge = 0
		return

	//dont start recharging until we are ready
	if(world.time > shield_next_charge)
		//always take 10 ticks to get to full
		shield_current_charge += shield_max_charge / 15

		///dont overflow
		if(shield_current_charge > shield_max_charge)
			shield_current_charge = shield_max_charge

		//automatically come back up after an overload
		var/mob/M = src.loc
		if(overloaded)
			overloaded = 0
			shield_current_charge = shield_max_charge / 2
			if(try_activate())
				//tell our holder
				to_chat(M,"\icon[connected_shield] <span class='notice'>[src] flares back to life!</span>")
			else
				update_icon()
		else
			update_icon()

		if(istype(M))
			to_chat(M,"\icon[connected_shield] <span class='info'>[src] is now at [shield_charge_string()].</span>")



#undef GAUNTLET_WARNING_DELAY

//shield subtype defines//

/obj/item/clothing/gloves/shield_gauntlet/kigyar
	name = "Kig-Yar Point Defense Gauntlet"
	desc = "A wrist-worn gauntlet that contains a directional shield generator, allowing it to provide protection from gunfire in the direction the user is facing."
	species_restricted = list(SPECIES_KIGYAR_YW)
	body_parts_covered = HANDS
	armor = list(melee = 30, bullet = 40, laser = 10, energy = 25, bomb = 15, bio = 0, rad = 0)
	siemens_coefficient = 0.15

/obj/item/clothing/gloves/shield_gauntlet/unsc
	name = "Experimental UNSC Energy-Shield Gauntlet"
	desc = "A wrist-worn gauntlet that containes a reverse-engineered shield generator. It looks experimental and... dangerous."
	species_restricted = list("Human","Spartan")
	body_parts_covered = HANDS
	armor = list(melee = 30, bullet = 40, laser = 10, energy = 25, bomb = 15, bio = 0, rad = 0)
	siemens_coefficient = 0.15
