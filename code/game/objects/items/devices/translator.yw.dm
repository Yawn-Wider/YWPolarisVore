obj/item/translator_upgrade
	name = "universal translation upgrade"
	desc = "An upgrade for translators that increases their translation ability"
	icon = 'icons/obj/radio.dmi'
	icon_state = "bin_cypherkey"


/obj/item/device/universal_translator/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/translator_upgrade))
		if(universal)
			to_chat(user, "<span class='warning'>The [src] is already upgraded!</span>")
		else
			universal = 1
			qdel(W)
			to_chat(user, "<span class='notice'>You install the upgrade into [src]</span>")
	else
		return ..()