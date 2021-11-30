/obj/structure/musician
	name = "Not A Piano"
	desc = "Something broke, contact coderbus."
	var/can_play_unanchored = FALSE
	var/list/allowed_instrument_ids = list("r3grand","r3harpsi","crharpsi","crgrand1","crbright1", "crichugan", "crihamgan","piano")
	var/datum/song/song

/obj/structure/musician/Initialize(mapload)
	. = ..()
	song = new(src, allowed_instrument_ids)
	allowed_instrument_ids = null

/obj/structure/musician/Destroy()
	QDEL_NULL(song)
	return ..()

/obj/structure/musician/attack_hand(mob/M)
	if(!M.IsAdvancedToolUser())
		return
	
	interact(M)

/obj/structure/musician/proc/should_stop_playing(mob/user)
	if(!(anchored || can_play_unanchored))
		return TRUE
	if(!user)
		return FALSE
	return !CanUseTopic(user)

/obj/structure/musician/interact(mob/user)
	. = ..()
	song.interact(user)

/*
/obj/structure/musician/wrench_act(mob/living/user, obj/item/I)
	default_unfasten_wrench(user, I, 40)
	return TRUE
*/

/obj/structure/musician/piano
	name = "space minimoog"
	icon = 'icons/obj/musician.dmi'
	icon_state = "minimoog"
	anchored = TRUE
	density = TRUE

/obj/structure/musician/piano/unanchored
	anchored = FALSE

/obj/structure/musician/piano/Initialize(mapload)
	. = ..()
	if(prob(50) && icon_state == initial(icon_state))
		name = "space minimoog"
		desc = "This is a minimoog, like a space piano, but more spacey!"
		icon_state = "minimoog"
	else
		name = "space piano"
		desc = "This is a space piano, like a regular piano, but always in tune! Even if the musician isn't."
		icon_state = "piano"

// YW Addition: makes it so you can move the piano using the wrench
/obj/structure/musician/piano/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(!W.is_wrench())
		return FALSE
	playsound(src, W.usesound, 50, 1)
	var/actual_time = W.toolspeed * 40
	if(actual_time != 0)
		user.visible_message( \
			"<span class='warning'>\The [user] begins [anchored ? "un" : ""]securing \the [src].</span>", \
			"<span class='notice'>You start [anchored ? "un" : ""]securing \the [src].</span>")
	if(actual_time == 0 || do_after(user, actual_time, target = src))
		user.visible_message( \
			"<span class='warning'>\The [user] has [anchored ? "un" : ""]secured \the [src].</span>", \
			"<span class='notice'>You [anchored ? "un" : ""]secure \the [src].</span>")
		anchored = !anchored
		update_icon()
	return TRUE