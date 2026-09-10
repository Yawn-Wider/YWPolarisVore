/obj/effect/esword_path
	name = "displaced air"
	icon = null
	icon_state = null

/obj/item/melee/energy/elite_sword
	name = "Type-1 Energy Weapon"
	desc = "A small handle conceals the equipment required to generate a long shimmering blade of shaped plasma, capable of burning through most armor with ease."
	icon = 'code/modules/yw-halo/weapons/icons/Covenant_Weapons.dmi'
	icon_state = "T1EW Handle"
	var/icon_state_deployed = "T1EW-deployed"
	var/inhand_icon_state = "Energy sword_inhand Human" // " l" or " r" is added after this to make the variants
	force = 1
	throwforce = 1
	active_force = 50
	active_throwforce = 12
	armor_penetration = 70
	var/hits_burn_mobs = 1
	edge = 0
	sharp = 0
	var/failsafe = 0
	slot_flags = SLOT_POCKET | SLOT_BELT
	matter = list("nanolaminate" = 1)

	unacidable = 1
	var/decapitate = TRUE

/obj/item/melee/energy/elite_sword/New()
	. = ..()
	verbs += /obj/item/melee/energy/elite_sword/proc/enable_failsafe

/obj/item/melee/energy/elite_sword/proc/enable_failsafe()
	set name = "Enable weapon failsafe"
	set category = "IC"
	failsafe = 1
	to_chat(usr,"<span class='info'>WARNING! You enable [src]'s failsafe. [src] will now self destruct if you drop it while active.</span>")
	verbs -= /obj/item/melee/energy/elite_sword/proc/enable_failsafe
	verbs += /obj/item/melee/energy/elite_sword/proc/disable_failsafe

/obj/item/melee/energy/elite_sword/proc/disable_failsafe()
	set name = "Disable weapon failsafe"
	set category = "IC"
	failsafe = 0
	to_chat(usr,"<span class='info'>You disable [src]'s failsafe. [src] will no longer self destruct if you drop it.</span>")
	verbs += /obj/item/melee/energy/elite_sword/proc/enable_failsafe
	verbs -= /obj/item/melee/energy/elite_sword/proc/disable_failsafe

/obj/item/melee/energy/elite_sword/proc/change_misc_variables(var/deactivate = 0)
	if(deactivate)
		item_icons = list(slot_l_hand_str = null,slot_r_hand_str = null)
		item_state_slots = null
		hitsound = "swing_hit"
	else
		item_icons = list(slot_l_hand_str ='code/modules/yw-halo/icons/Energy_Sword_inhand_Human.dmi',slot_r_hand_str = 'code/modules/yw-halo/icons/Energy_Sword_inhand_Human.dmi')
		item_state_slots = list(
		slot_l_hand_str = "[inhand_icon_state] l",
		slot_r_hand_str = "[inhand_icon_state] r" )
		hitsound = 'code/modules/yw-halo/sounds/Energyswordhit.ogg'

/obj/item/melee/energy/elite_sword/activate(mob/living/user)
	..()
	to_chat(user, "<span class='notice'>\The [src] bursts from its handle.</span>")
	icon_state = icon_state_deployed
	w_class = ITEMSIZE_LARGE
	edge = 1
	sharp = 1
	flags = NOBLOODY
	change_misc_variables()

/obj/item/melee/energy/elite_sword/deactivate(mob/living/user)
	..()
	icon_state = initial(icon_state)
	to_chat(user, "<span class='notice'>\The [src] disappears in a flash of light.</span>")
	w_class = ITEMSIZE_SMALL
	flags = null
	change_misc_variables(1)

/obj/item/melee/energy/elite_sword/dropped(var/mob/user)
	. = ..()
	if(loc == null) //We probably shouldn't be exploding if we're in nullspace.
		return
	if(!istype(loc,/mob))
		if(icon_state == icon_state_deployed)
			if(failsafe)
				src.visible_message("<span class='warning'>[src] bursts into a superheated flash of plasma!</span>")
				flick("[icon_state_deployed]-burnout",src)
				spawn(5)
					var/mob/living/M = src.loc
					if(istype(M))
						//burn whoever tried to pick us up
						M.apply_damage(75, BURN, def_zone = pick(BP_L_HAND, BP_R_HAND))
					else
						//burn everyone nearby
						for(var/mob/living/L in range(0,src))
							L.apply_damage(15, BURN)
					qdel(src)
			else
				deactivate(user)

/obj/item/melee/energy/elite_sword/attack(var/mob/m,var/mob/user)
	if(ismob(m) && hits_burn_mobs)
		damtype = BURN
	return ..()

/obj/item/melee/energy/elite_sword/dagger
	name = "Energy Dagger"
	desc = "Utilising the same technology as the type-1 energy weapon, this dagger projects blades of plasma."
	icon = 'code/modules/yw-halo/weapons/icons/Covenant_Weapons.dmi'
	icon_state = "en_dag_handle"
	icon_state_deployed = "en_dag_deploy"
	w_class = ITEMSIZE_SMALL
	active_force = 30
	active_throwforce = 12
	armor_penetration = 70
	edge = 0
	sharp = 0

/obj/item/melee/energy/elite_sword/dagger/activate(mob/living/user)
	..()
	w_class = ITEMSIZE_NORMAL

/obj/item/melee/energy/elite_sword/dagger/deactivate(mob/living/user)
	..()
	w_class = ITEMSIZE_SMALL

/obj/item/melee/energy/elite_sword/dagger/change_misc_variables(var/deactivate = 0)
	if(deactivate)
		item_icons = list(slot_l_hand_str = null,slot_r_hand_str = null)
		item_state_slots = null
		hitsound = "swing_hit"
	else
		item_icons = list(slot_l_hand_str ='code/modules/yw-halo/icons/energy_dagger_inhand.dmi',slot_r_hand_str = 'code/modules/yw-halo/icons/energy_dagger_inhand.dmi')
		item_state_slots = list(
		slot_l_hand_str = "en_dag_l_hand",
		slot_r_hand_str = "en_dag_r_hand" )
		hitsound = 'code/modules/yw-halo/sounds/Energyswordhit.ogg'

//HONOUR GUARD STAFF

/obj/item/melee/energy/elite_sword/honour_staff
	name = "Honour Guard Staff"
	desc = "A ceremonial staff typically wielded by Sangheili Honour Guards. While not fit for a true battle, it serves well for beating unruly unngoy."
	icon = 'code/modules/yw-halo/weapons/icons/Covenant_Weapons.dmi'
	icon_state = "honourstaff"
	//icon_state_deployed = "honourstaff-active"
	w_class = ITEMSIZE_HUGE
	slot_flags = SLOT_BACK
	force = 40
	armor_penetration = 40
	hits_burn_mobs = 0
	//active_force = 60
	matter = list("nanolaminate" = 5)
	throwforce = 10
	damtype = HALLOSS
	item_icons = list(
		slot_l_hand_str = 'code/modules/yw-halo/weapons/icons/Weapon_Inhands_left.dmi',
		slot_r_hand_str = 'code/modules/yw-halo/weapons/icons/Weapon_Inhands_right.dmi',
		)

/obj/item/melee/energy/elite_sword/honour_staff/change_misc_variables(var/deactivate = 0)
	if(deactivate)
		hitsound = "swing_hit"
		damtype = HALLOSS
	else
		hitsound = 'code/modules/yw-halo/sounds/Energyswordhit.ogg'
		damtype = BURN

/obj/item/material/shard/shrapnel/blamite
	name = "Blamite Blade"

/obj/item/melee/blamite
	name = "Blamite Weapon"
	desc = "\
A weapon with a blade made of Blamite. An internal mechanism cultivates the quick growth of a blamite crystal, \
although this leaves it brittle and prone to breaking. \
Luckily, this isn't a downside due to the explosive properties of such a large and quick grown crystal."
	icon = 'code/modules/yw-halo/weapons/icons/blamite.dmi'
	icon_state = "invalid"
	item_icons = list(slot_l_hand_str ='code/modules/yw-halo/weapons/icons/Weapon_Inhands_right.dmi',slot_r_hand_str = 'code/modules/yw-halo/weapons/icons/Weapon_Inhands_right.dmi')
	w_class = ITEMSIZE_LARGE
	slot_flags = SLOT_BACK | SLOT_BELT | SLOT_POCKET
	edge = 1
	sharp = 1
	armor_penetration = 70
	matter = list("nanolaminate" = 1)
	var/explode_delay = 10 SECONDS
	var/explode_at = -1
	var/regen_delay = 2 MINUTES
	var/regen_at = -1
	var/explode_damage = 60

/obj/item/melee/blamite/update_icon()
	if(regen_at != -1)
		icon_state = "[initial(icon_state)]_handle"
	else if(explode_at != -1)
		icon_state = "[initial(icon_state)]_charging"
	else
		icon_state = initial(icon_state)

/obj/item/melee/blamite/proc/set_blade_active(var/active)
	if(active)
		force = initial(force)
		throwforce = initial(throwforce)
		armor_penetration = initial(armor_penetration)
	else
		force = 5
		throwforce = 5
		armor_penetration = 0

/obj/item/melee/blamite/proc/regen_crystal()
	regen_at = -1
	update_icon()
	set_blade_active(1)

/obj/item/melee/blamite/proc/det_in_hand()
	regen_at = world.time + regen_delay * 2
	explode_at = -1
	update_icon()
	set_blade_active(0)
	//you fucked up and held it for too long. kablooey//
	var/mob/living/holder = loc
	if(istype(holder))
		holder.adjustFireLoss(explode_damage * 1.5) //Enough to gib a limb
		holder.visible_message("<span class = 'danger'>[name] overloads, burning [holder.name]!</span>")
	else
		visible_message("<span class = 'warning'>[name] overloads, singing the air around it!</span>")

/obj/item/melee/blamite/proc/do_explode_in_player(var/mob/living/player, var/silent = FALSE)
	//Kabloeey in a player//
	if(player)
		player.adjustFireLoss(explode_damage)
		if(!silent)
			player.visible_message("<span class = 'notice'>The embedded Blamite Blade overloads, burning [player.name]!</span>")

/obj/item/melee/blamite/proc/pre_explode_in_player(var/mob/living/user,var/mob/living/carbon/human/target, var/silent = FALSE)
	if(!istype(target))
		return
	if(!silent)
		user.visible_message("<span class = 'warning'>[user.name] lodges the blade of their [name] into [target.name], snapping it off at the hilt.</span>")
	regen_at = world.time + regen_delay
	explode_at = -1
	update_icon()
	set_blade_active(0)
	//Create shard, embed in enemy. Delay explosion by timeframe, then check for shard again. If present, call do_explode_in_player()//
	var/obj/shard = new /obj/item/material/shard/shrapnel/blamite
	shard.name = initial(shard.name)
	var/obj/item/organ/external/embed_organ = pick(target.organs)
	embed_organ.embed(shard)
	spawn(explode_delay)
		if(target && locate(/obj/item/material/shard/shrapnel/blamite) in target.embedded)
			do_explode_in_player(target, silent)

/obj/item/melee/blamite/attack_self(var/mob/user)
	if(regen_at != -1)
		to_chat(user,"<span class = 'notice'>[name] has no blade to prime for explosion!</span>")
		return
	if(explode_at != -1)
		to_chat(user,"<span class = 'notice'>[name] is already primed for explosion.</span>")
		return
	user.visible_message("<span class = 'warning'>[user.name] primes their [src] for detonation!</span>")
	explode_at = world.time + explode_delay
	update_icon()


/obj/item/melee/blamite/process()
	if(explode_at != -1 && world.time > explode_at)
		det_in_hand()
	if(regen_at != -1 && world.time > regen_at)
		regen_crystal()

/obj/item/melee/blamite/apply_hit_effect(var/mob/living/carbon/human/target, mob/living/user, var/hit_zone)
	. = ..()
	if(explode_at == -1 || . == 100 || !istype(target))
		return
	pre_explode_in_player(user,target)

/obj/item/melee/blamite/cutlass
	name = "Blamite Cutlass"
	icon_state = "bl_cutlass"
	item_state = "blamite_cutlass"
	force = 35
	throwforce = 15

/obj/item/melee/blamite/dagger
	name = "Blamite Dagger"
	icon_state = "bl_dag"
	item_state = "blamite_dagger"
	force = 25
	throwforce = 10

/obj/item/melee/baton/humbler/covenant
	name = "Type-12 Antipersonnel Incapacitator"
	desc = "A retractable baton capable of inducing a large amount of pain via electrical shocks."
	icon = 'code/modules/yw-halo/weapons/icons/Covenant_Weapons.dmi'
	icon_state = "Type-12 Antipersonnel Incapacitator"
	item_state = "telebaton_0"
	matter = list("nanolaminate" = 1)
