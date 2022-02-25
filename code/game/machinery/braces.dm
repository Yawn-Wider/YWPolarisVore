// MAINTENANCE JACK - Allows removing of braces with certain delay.
// ported from https://github.com/Baystation12/Baystation12/blob/dev/code/game/machinery/doors/braces.dm, mostly, removed ID and electronics parts. Focuses entirely on maintnence jack lockdowns
/obj/item/weapon/crowbar/brace_jack
	name = "maintenance jack"
	desc = "A special crowbar that can be used to safely remove airlock braces from airlocks."
	w_class = ITEMSIZE_SMALL
	icon = 'icons/obj/tools_op.dmi'
	icon_state = "maintenance_jack"
	throwforce = 7
	force = 17.5 //It has a hammer head, should probably do some more damage. - Cirra
	pry = 1
	toolspeed = 1
	tool_qualities = list(TOOL_CROWBAR)
	origin_tech = list(TECH_ENGINEERING = 1)
	matter = list(MAT_DURASTEEL = 50)


// BRACE - Can be installed on airlock to reinforce it and keep it closed.
/obj/item/airlock_brace
	name = "airlock brace"
	desc = "A sturdy device that can be attached to an airlock to reinforce it and provide additional security."
	w_class = ITEMSIZE_LARGE
	icon = 'icons/obj/airlock_machines_op.dmi'
	icon_state = "brace_open"
	var/cur_health
	var/max_health = 450
	var/obj/machinery/door/airlock/airlock = null
	


/obj/item/airlock_brace/examine(mob/user)
	. = ..()
	. += examine_health()


// This is also called from airlock's examine, so it's a different proc to prevent code copypaste.
/obj/item/airlock_brace/proc/examine_health()
	switch(health_percentage())
		if(-100 to 25)
			return text("<span class='danger'>\The [src] looks seriously damaged, and probably won't last much more.</span>")
		if(25 to 50)
			return text("<span class='notice'>\The [src] looks damaged.</span>")
		if(50 to 75)
			return text("\The [src] looks slightly damaged.")
		if(75 to 99)
			return text("\The [src] has a few dents.")
		if(99 to INFINITY)
			return text("\The [src] is in excellent condition.")


/obj/item/airlock_brace/update_icon()
	if(airlock)
		// plane and layer set by airlock itself!
		icon_state = "brace_closed"
	else
		icon_state = "brace_open"
	..()


/obj/item/airlock_brace/New()
	..()
	cur_health = max_health

/obj/item/airlock_brace/Destroy()
	if(airlock)
		airlock.brace = null
		airlock = null
	..()


/obj/item/airlock_brace/attackby(obj/item/W as obj, mob/user as mob)
	..()
	if (istype(W, /obj/item/weapon/crowbar/brace_jack))
		if(!airlock)
			return
		var/obj/item/weapon/crowbar/brace_jack/C = W
		to_chat(user, "You begin forcibly removing \the [src] with \the [C].")
		playsound(user, 'sound/machines/door/airlock_creaking.ogg', 100, 1) // pulling doorjack up!
		if(do_after(user, rand(150,300), airlock))
			to_chat(user, "You finish removing \the [src].")
			unlock_brace(user)
		return

	if(istype(W, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/C = W
		if(cur_health == max_health)
			to_chat(user, "\The [src] does not require repairs.")
			return
		if(C.remove_fuel(0,user))
			playsound(src, 'sound/items/Welder.ogg', 100, 1)
			cur_health = min(cur_health + rand(80,120), max_health)
			if(cur_health == max_health)
				to_chat(user, "You repair some dents on \the [src]. It is in perfect condition now.")
			else
				to_chat(user, "You repair some dents on \the [src].")


/obj/item/airlock_brace/proc/lock_brace(var/airlk)
	if(airlock)
		return
	playsound( src, 'sound/machines/door/airlockforced.ogg', 50, 1)
	// lock brace to door
	airlock = airlk
	airlock.brace = src
	dropInto(airlock)
	anchored = TRUE
	// place brace on layer above door
	plane = airlock.plane
	layer = airlock.layer + 0.1
	// update icon
	update_icon()


/obj/item/airlock_brace/proc/unlock_brace(var/mob/user)
	if(!airlock)
		return
	playsound( src, 'sound/machines/door/airlockforced.ogg', 50, 1)
	// unlock brace to door
	airlock.brace = null
	airlock.update_icon()
	airlock = null
	anchored = FALSE
	// reset brace to item layer
	reset_plane_and_layer()
	update_icon()
	if(user)
		user.put_in_hands(src)
		airlock.visible_message("\The [user] removes \the [src] from \the [airlock]!")
	else
		dropInto(loc)


/obj/item/airlock_brace/proc/health_percentage()
	if(!max_health)
		return 0
	return (cur_health / max_health) * 100