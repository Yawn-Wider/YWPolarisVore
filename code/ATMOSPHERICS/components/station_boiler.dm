var/global/list/stationboilers = list() //Should only ever have one, caching to locate easily by radiators

/obj/machinery/atmospherics/binary/stationboiler
	name = "Station Boiler"
	desc = "A large, phoron-infused wood powered, super boiler. Capable of keeping a entire colony heated up"
	icon = 'icons/obj/machines/heat_boiler_yw.dmi'
	icon_state = "boiler_off"
	use_power = USE_POWER_OFF
	bullet_vulnerability = 0
	anchored = TRUE
	density = TRUE

	var/is_active = FALSE
	var/target_heat_temperature = T20C //The temperature we want the pipes to be heated to
	var/moles_to_process = 10
	var/wood_per_process = 1SECOND
	var/list/stored_material =  list(MAT_LOG = 1HOUR) //1 hour of mats free
	var/list/storage_capacity = list(MAT_LOG = 4HOUR) //can hold enough for 4 hours

/obj/machinery/atmospherics/binary/stationboiler/New()
	..()
	stationboilers.Add(src)
	var/image/I = image(icon = icon, icon_state = "boiler-pipe-overlay", dir = dir)
	I.color = PIPE_COLOR_BLUE
	add_overlay(I)
	I = image(icon = icon, icon_state = "boiler-pipe-overlay", dir = reverse_dir[dir])
	I.color = PIPE_COLOR_BLACK
	add_overlay(I)

/obj/machinery/atmospherics/binary/stationboiler/process()
	..()
	//STEP 1 - Pump gas through
	pump_gas(src, air1, air2, moles_to_process)
	if(network1)
		network1.update = 1
	if(network2)
		network2.update = 1

	//STEP 2 - Check if we can heat the gas
	if(stored_material[MAT_LOG] < wood_per_process) //Out of wood
		is_active = 0
		SSair.handle_planet_temperature_change = 1 //Start cooling down the world
		update_icon()
		return

	is_active = 1
	//We have wood - SSAir can stop handling temperatures
	SSair.handle_planet_temperature_change = 0

	//STEP 3 - Consume the resources
	stored_material[MAT_LOG] -= wood_per_process
	stored_material[MAT_LOG] = max(stored_material[MAT_LOG], 0)

	//Heat up the air instantly, magically
	air2.temperature = target_heat_temperature
	update_icon()

/obj/machinery/atmospherics/binary/stationboiler/update_icon()
	if(stored_material[MAT_LOG] < wood_per_process)
		icon_state = "boiler_off"
	else
		icon_state = "boiler_on"
	return 1

// Attept to load materials.  Returns 0 if item wasn't a stack of materials, otherwise 1 (even if failed to load)
/obj/machinery/atmospherics/binary/stationboiler/proc/try_load_materials(var/mob/user, var/obj/item/stack/material/S)
	if(!istype(S))
		return 0
	if(!(S.material.name in stored_material))
		to_chat(user, "<span class='warning'>\The [src] doesn't accept [material_display_name(S.material)]!</span>")
		return 1
	var/max_res_amount = storage_capacity[S.material.name]
	if(stored_material[S.material.name] + S.perunit <= max_res_amount)
		var/count = 0
		while(stored_material[S.material.name] + S.perunit <= max_res_amount && S.get_amount() >= 1)
			stored_material[S.material.name] += S.perunit
			S.use(1)
			count++
		user.visible_message("\The [user] inserts [S.name] into \the [src].", "<span class='notice'>You insert [count] [S.name] into \the [src].</span>")
		updateUsrDialog()
	else
		to_chat(user, "<span class='warning'>\The [src] cannot hold more [S.name].</span>")
	return 1

/obj/machinery/atmospherics/binary/stationboiler/attackby(obj/item/weapon/W as obj, mob/user as mob)
	add_fingerprint(user)
	if(try_load_materials(user, W))
		return
	else
		to_chat(user, "<span class='notice'>You cannot insert this item into \the [src]!</span>")
		return

/obj/machinery/atmospherics/binary/stationboiler/tgui_act(action, params)
	if(..())
		return TRUE
	add_fingerprint(usr)

	switch(action)
		if("ejectMaterial")
			var/matName = params["mat"]
			if(!(matName in stored_material))
				return
			eject_materials(matName, 0)
			. = TRUE

/obj/machinery/atmospherics/binary/stationboiler/fall_apart(var/severity = 3, var/scatter = TRUE)
	return //Invincible machine

// 0 amount = 0 means ejecting a full stack; -1 means eject everything
/obj/machinery/atmospherics/binary/stationboiler/proc/eject_materials(var/material_name, var/amount)
	var/recursive = amount == -1 ? 1 : 0
	var/datum/material/matdata = get_material_by_name(material_name)
	var/stack_type = matdata.stack_type
	var/obj/item/stack/material/S = new stack_type(loc)
	if(amount <= 0)
		amount = S.max_amount
	var/ejected = min(round(stored_material[material_name] / S.perunit), amount)
	if(!S.set_amount(min(ejected, amount)))
		return
	stored_material[material_name] -= ejected * S.perunit
	if(recursive && stored_material[material_name] >= S.perunit)
		eject_materials(material_name, -1)
