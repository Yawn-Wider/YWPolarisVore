/obj/machinery/air_sensor
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "gsensor1"
	name = "Gas Sensor"
	desc = "Senses atmospheric conditions."
	settagwhitelist = list("id_tag")

	anchored = 1
	var/state = 0

	var/id_tag
	var/frequency = 1439

	var/on = 1
	var/bolts = 1
	var/output = 3
	//Flags:
	// 1 for pressure
	// 2 for temperature
	// Output >= 4 includes gas composition
	// 4 for oxygen concentration
	// 8 for phoron concentration
	// 16 for nitrogen concentration
	// 32 for carbon dioxide concentration

	var/datum/radio_frequency/radio_connection

/obj/machinery/air_sensor/update_icon()
	icon_state = "gsensor[on]"

/obj/machinery/air_sensor/process()
	if(on)
		var/datum/signal/signal = new
		signal.transmission_method = TRANSMISSION_RADIO //radio signal
		signal.data["tag"] = id_tag
		signal.data["timestamp"] = world.time

		var/datum/gas_mixture/air_sample = return_air()

		if(output&1)
			signal.data["pressure"] = num2text(round(air_sample.return_pressure(),0.1),)
		if(output&2)
			signal.data["temperature"] = round(air_sample.temperature,0.1)

		if(output>4)
			var/total_moles = air_sample.total_moles
			if(total_moles > 0)
				if(output&4)
					signal.data["oxygen"] = round(100*air_sample.gas["oxygen"]/total_moles,0.1)
				if(output&8)
					signal.data["phoron"] = round(100*air_sample.gas["phoron"]/total_moles,0.1)
				if(output&16)
					signal.data["nitrogen"] = round(100*air_sample.gas["nitrogen"]/total_moles,0.1)
				if(output&32)
					signal.data["carbon_dioxide"] = round(100*air_sample.gas["carbon_dioxide"]/total_moles,0.1)
			else
				signal.data["oxygen"] = 0
				signal.data["phoron"] = 0
				signal.data["nitrogen"] = 0
				signal.data["carbon_dioxide"] = 0
		signal.data["sigtype"]="status"
		radio_connection.post_signal(src, signal, radio_filter = RADIO_ATMOSIA)


/obj/machinery/air_sensor/multitool_menu(var/mob/user, var/obj/item/multitool/P)
	return {"
	<b>Main</b>
	<ul>
		<li><b>Frequency:</b> <a href="?src=\ref[src];set_freq=-1">[format_frequency(frequency)] GHz</a> (<a href="?src=\ref[src];set_freq=[initial(frequency)]">Reset</a>)</li>
		<li>[format_tag("ID Tag","id_tag", "set_id")]</li>
		<li>Floor Bolts: <a href="?src=\ref[src];toggle_bolts=1">[bolts ? "Enabled" : "Disabled"]</a>
		<li>Monitor Pressure: <a href="?src=\ref[src];toggle_out_flag=1">[output&1 ? "Yes" : "No"]</a>
		<li>Monitor Temperature: <a href="?src=\ref[src];toggle_out_flag=2">[output&2 ? "Yes" : "No"]</a>
		<li>Monitor Oxygen Concentration: <a href="?src=\ref[src];toggle_out_flag=4">[output&4 ? "Yes" : "No"]</a>
		<li>Monitor Plasma Concentration: <a href="?src=\ref[src];toggle_out_flag=8">[output&8 ? "Yes" : "No"]</a>
		<li>Monitor Nitrogen Concentration: <a href="?src=\ref[src];toggle_out_flag=16">[output&16 ? "Yes" : "No"]</a>
		<li>Monitor Carbon Dioxide Concentration: <a href="?src=\ref[src];toggle_out_flag=32">[output&32 ? "Yes" : "No"]</a>
	</ul>"}

/obj/machinery/air_sensor/multitool_topic(var/mob/user, var/list/href_list, var/obj/O)
	. = ..()
	if(.)
		return .

	if("toggle_out_flag" in href_list)
		var/bitflag_value = text2num(href_list["toggle_out_flag"])//this is a string normally
		if(!(bitflag_value in list(1, 2, 4, 8, 16, 32))) //Here to prevent breaking the sensors with HREF exploits
			return 0
		if(output&bitflag_value)//the bitflag is on ATM
			output &= ~bitflag_value
		else//can't not be off
			output |= bitflag_value
		return TRUE
	if("toggle_bolts" in href_list)
		bolts = !bolts
		if(bolts)
			visible_message("You hear a quite click as the [src] bolts to the floor", "You hear a quite click")
		else
			visible_message("You hear a quite click as the [src]'s floor bolts raise", "You hear a quite click")
		return TRUE



/obj/machinery/air_sensor/attackby(var/obj/item/W as obj, var/mob/user as mob)
	if(istype(W, /obj/item/device/multitool))
		update_multitool_menu(user)
		return 1
	if(istype(W, /obj/item/weapon/tool/wrench))
		if(bolts)
			to_chat(usr, "The [src] is bolted to the floor! You can't detach it like this.")
			return 1
		playsound(loc, W.usesound, 50, 1)
		to_chat(user, "<span class='notice'>You begin to unfasten \the [src]...</span>")
		if(do_after(user, 40 * W.toolspeed, target = src))
			user.visible_message("[user] unfastens \the [src].", "<span class='notice'>You have unfastened \the [src].</span>", "You hear ratchet.")
			new /obj/item/pipe_gsensor(src.loc)
			qdel(src)
			return 1
		return
	return ..()

/obj/machinery/air_sensor/proc/set_frequency(new_frequency)
	radio_controller.remove_object(src, frequency)
	frequency = new_frequency
	radio_connection = radio_controller.add_object(src, frequency, RADIO_ATMOSIA)

/obj/machinery/air_sensor/Initialize()
	. = ..()
	if(frequency)
		set_frequency(frequency)

obj/machinery/air_sensor/Destroy()
	if(radio_controller)
		radio_controller.remove_object(src,frequency)
	. = ..()

/obj/machinery/computer/general_air_control
	icon_keyboard = "atmos_key"
	icon_screen = "tank"
	name = "Computer"
	desc = "Control atmospheric systems, remotely."
	var/frequency = 1439
	var/list/sensors = list()
	var/list/sensor_information = list()
	var/datum/radio_frequency/radio_connection
	circuit = /obj/item/weapon/circuitboard/air_management

obj/machinery/computer/general_air_control/Destroy()
	if(radio_controller)
		radio_controller.remove_object(src, frequency)
	..()

/obj/machinery/computer/general_air_control/attackby(I as obj, user as mob, params)
	if(istype(I, /obj/item/device/multitool))
		update_multitool_menu(user)
		return 1
	return ..()

/obj/machinery/computer/general_air_control/attack_hand(mob/user)
	if(..(user))
		return

	ui_interact(user)

/obj/machinery/computer/general_air_control/receive_signal(datum/signal/signal)
	if(!signal || signal.encryption) return

	var/id_tag = signal.data["tag"]
	if(!id_tag || !sensors.Find(id_tag)) return

	sensor_information[id_tag] = signal.data

/obj/machinery/computer/general_air_control/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	user.set_machine(src)

	var/list/data = list()
	var/sensors_ui[0]
	if(sensors.len)
		for(var/id_tag in sensors)
			var/long_name = sensors[id_tag]
			var/list/sensor_data = sensor_information[id_tag]
			sensors_ui[++sensors_ui.len] = list("long_name" = long_name, "sensor_data" = sensor_data)
	else
		sensors_ui = null

	data["sensors"] = sensors_ui

	ui = SSnanoui.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "atmo_control.tmpl", name, 525, 600)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(5)

/obj/machinery/computer/general_air_control/proc/set_frequency(new_frequency)
	radio_controller.remove_object(src, frequency)
	frequency = new_frequency
	radio_connection = radio_controller.add_object(src, frequency, RADIO_ATMOSIA)

/obj/machinery/computer/general_air_control/Initialize()
	. = ..()
	if(frequency)
		set_frequency(frequency)

/obj/machinery/computer/general_air_control/multitool_menu(mob/user, obj/item/multitool/P)
	var/dat= {"
	<b>Main</b>
	<ul>
	<li><b>Frequency:</b> <a href="?src=\ref[src];set_freq=-1">[format_frequency(frequency)] GHz</a> (<a href="?src=\ref[src];set_freq=[initial(frequency)]">Reset</a>)</li>
	</ul>
	<b>Sensors:</b>
	<ul>"}
	for(var/id_tag in sensors)
		dat += {"<li><a href="?src=\ref[src];edit_sensor=[id_tag]">[sensors[id_tag]]</a></li>"}
	dat += {"<li><a href="?src=\ref[src];add_sensor=1">\[+\]</a></li></ul>"}
	return dat

/obj/machinery/computer/general_air_control/multitool_topic(mob/user,list/href_list,obj/O)
	. = ..()
	if(.) return .
	if("add_sensor" in href_list)

		// Make a list of all available sensors on the same frequency
		var/list/sensor_list = list()
		for(var/obj/machinery/air_sensor/G)
			if(!isnull(G.id_tag) && G.frequency == frequency)
				sensor_list|=G.id_tag
		if(!sensor_list.len)
			to_chat(user, "<span class=\"warning\">No sensors on this frequency.</span>")
			return FALSE

		// Have the user pick one of them and name its label
		var/sensor = input(user, "Select a sensor:", "Sensor Data") as null|anything in sensor_list
		if(!sensor)
			return FALSE
		var/label = sanitize(input(user, "Choose a sensor label:", "Sensor Label")  as text|null)
		if(!label)
			return FALSE

		// Add the sensor's information to general_air_controler
		sensors[sensor] = label
		return TRUE

	if("edit_sensor" in href_list)
		var/list/sensor_list = list()
		for(var/obj/machinery/air_sensor/G)
			if(!isnull(G.id_tag) && G.frequency == frequency)
				sensor_list|=G.id_tag
		if(!sensor_list.len)
			to_chat(user, "<span class=\"warning\">No sensors on this frequency.</span>")
			return FALSE
		var/label = sensors[href_list["edit_sensor"]]
		var/sensor = input(user, "Select a sensor:", "Sensor Data", href_list["edit_sensor"]) as null|anything in sensor_list
		if(!sensor)
			return FALSE
		sensors.Remove(href_list["edit_sensor"])
		sensors[sensor] = label
		return TRUE

/obj/machinery/computer/general_air_control/unlinkFrom(mob/user, obj/O)
	..()
	if("id_tag" in O.vars && (istype(O,/obj/machinery/air_sensor) || istype(O, /obj/machinery/meter)))
		sensors.Remove(O:id_tag)
		return 1
	return 0

/obj/machinery/computer/general_air_control/linkMenu(obj/O)
	if(isLinkedWith(O))
		return

	var/dat=""

	if(istype(O,/obj/machinery/air_sensor) || istype(O, /obj/machinery/meter))
		dat += " <a href='?src=\ref[src];link=1'>\[New Sensor\]</a> "
	return dat

/obj/machinery/computer/general_air_control/canLink(obj/O, list/context)
	if(istype(O,/obj/machinery/air_sensor) || istype(O, /obj/machinery/meter))
		return O:id_tag

/obj/machinery/computer/general_air_control/isLinkedWith(obj/O)
	if(istype(O,/obj/machinery/air_sensor) || istype(O, /obj/machinery/meter))
		return O:id_tag in sensors

/obj/machinery/computer/general_air_control/linkWith(mob/user, obj/O, link/context)
	sensors[O:id_tag] = sanitize(input(user, "Choose a sensor label:", "Sensor Label") as text|null)
	return 1

/obj/machinery/computer/general_air_control/large_tank_control
	icon = 'icons/obj/computer.dmi'
	frequency = 1441
	settagwhitelist = list("input_tag", "output_tag")
	var/input_tag
	var/output_tag
	var/list/input_info
	var/list/output_info
	var/list/input_linkable=list(
		/obj/machinery/atmospherics/unary/outlet_injector,
		/obj/machinery/atmospherics/unary/vent_pump
	)

	var/list/output_linkable=list(
		/obj/machinery/atmospherics/unary/vent_pump
	)
	var/input_flow_setting = 200
	var/pressure_setting = ONE_ATMOSPHERE * 45
	circuit = /obj/item/weapon/circuitboard/air_management/tank_control

/obj/machinery/computer/general_air_control/large_tank_control/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	user.set_machine(src)

	var/list/data = list()
	var/sensors_ui[0]
	if(sensors.len)
		for(var/id_tag in sensors)
			var/long_name = sensors[id_tag]
			var/list/sensor_data = sensor_information[id_tag]
			sensors_ui[++sensors_ui.len] = list("long_name" = long_name, "sensor_data" = sensor_data)
	else
		sensors_ui = null

	data["sensors"] = sensors_ui
	data["tanks"] = 1

	if(input_info)
		data["input_info"] = list("power" = input_info["power"], "volume_rate" = round(input_info["volume_rate"], 0.1))
	else
		data["input_info"] = null

	if(output_info)
		data["output_info"] = list("power" = output_info["power"], "output_pressure" = output_info["internal"])
	else
		data["output_info"] = null

	data["input_flow_setting"] = round(input_flow_setting, 0.1)
	data["pressure_setting"] = pressure_setting

	ui = SSnanoui.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "atmo_control.tmpl", name, 660, 500)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(5)

/obj/machinery/computer/general_air_control/large_tank_control/receive_signal(datum/signal/signal)
	if(!signal || signal.encryption) return

	var/id_tag = signal.data["tag"]

	if(input_tag == id_tag)
		input_info = signal.data
	else if(output_tag == id_tag)
		output_info = signal.data
	else
		..(signal)

/obj/machinery/computer/general_air_control/large_tank_control/Topic(href, href_list)
	if(..())
		return 1

	if(href_list["adj_pressure"])
		var/change = text2num(href_list["adj_pressure"])
		pressure_setting = between(0, pressure_setting + change, 50*ONE_ATMOSPHERE)
		return 1

	if(href_list["adj_input_flow_rate"])
		var/change = text2num(href_list["adj_input_flow_rate"])
		input_flow_setting = between(0, input_flow_setting + change, ATMOS_DEFAULT_VOLUME_PUMP + 500) //default flow rate limit for air injectors
		return 1

	if(!radio_connection)
		return 0
	var/datum/signal/signal = new
	signal.transmission_method = TRANSMISSION_RADIO //radio signal
	signal.source = src
	if(href_list["in_refresh_status"])
		input_info = null
		signal.data = list ("tag" = input_tag, "status" = 1)
		. = 1

	if(href_list["in_toggle_injector"])
		input_info = null
		signal.data = list ("tag" = input_tag, "power_toggle" = 1)
		. = 1

	if(href_list["in_set_flowrate"])
		input_info = null
		signal.data = list ("tag" = input_tag, "set_volume_rate" = "[input_flow_setting]")
		. = 1

	if(href_list["out_refresh_status"])
		output_info = null
		signal.data = list ("tag" = output_tag, "status" = 1)
		. = 1

	if(href_list["out_toggle_power"])
		output_info = null
		signal.data = list ("tag" = output_tag, "power_toggle" = 1)
		. = 1

	if(href_list["out_set_pressure"])
		output_info = null
		signal.data = list ("tag" = output_tag, "set_internal_pressure" = "[pressure_setting]")
		. = 1

	signal.data["sigtype"]="command"
	radio_connection.post_signal(src, signal, radio_filter = RADIO_ATMOSIA)

/obj/machinery/computer/general_air_control/large_tank_control/attackby(I as obj, user as mob)
	if(istype(I, /obj/item/device/multitool))
		update_multitool_menu(user)
		return 1
	return ..()

/obj/machinery/computer/general_air_control/large_tank_control/multitool_menu(mob/user, obj/item/multitool/P)
	var/dat= {"
	<ul>
		<li><b>Frequency:</b> <a href="?src=\ref[src];set_freq=-1">[format_frequency(frequency)] GHz</a> (<a href="?src=\ref[src];set_freq=[initial(frequency)]">Reset</a>)</li>
		<li>[format_tag("Input","input_tag")]</li>
		<li>[format_tag("Output","output_tag")]</li>
	</ul>
	<b>Sensors:</b>
	<ul>"}
	for(var/id_tag in sensors)
		dat += {"<li><a href="?src=\ref[src];edit_sensor=[id_tag]">[sensors[id_tag]]</a></li>"}
	dat += {"<li><a href="?src=\ref[src];add_sensor=1">\[+\]</a></li></ul>"}
	return dat


/*/obj/machinery/computer/general_air_control/large_tank_control/linkWith(mob/user, obj/O, list/context)
	if(context["slot"]=="input" && is_type_in_list(O,input_linkable))
		input_info = null
		if(istype(O,/obj/machinery/atmospherics/unary/vent_pump))
			send_signal(list("tag"=input_tag,
				"direction"=1, // Release
				"checks"   =0  // No pressure checks.
				))
		return 1
	if(context["slot"]=="output" && is_type_in_list(O,output_linkable))
		output_tag = O:id_tag
		output_info = null
		if(istype(O,/obj/machinery/atmospherics/unary/vent_pump))
			send_signal(list("tag"=output_tag,
				"direction"=0, // Siphon
				"checks"   =2  // Internal pressure checks.
				))
		return 1*/

/obj/machinery/computer/general_air_control/large_tank_control/unlinkFrom(mob/user, obj/O)
	if("id_tag" in O.vars)
		if(O:id_tag == input_tag)
			input_tag=null
			input_info=null
			return 1
		if(O:id_tag == output_tag)
			output_tag=null
			output_info=null
			return 1
	return 0

/obj/machinery/computer/general_air_control/large_tank_control/linkMenu(obj/O)
	var/dat=""
	if(canLink(O,list("slot"="input")))
		dat += " <a href='?src=\ref[src];link=1;slot=input'>\[Link @ Input\]</a> "
	if(canLink(O,list("slot"="output")))
		dat += " <a href='?src=\ref[src];link=1;slot=output'>\[Link @ Output\]</a> "
	return dat

/obj/machinery/computer/general_air_control/large_tank_control/canLink(obj/O, list/context)
	return (context["slot"]=="input" && is_type_in_list(O,input_linkable)) || (context["slot"]=="output" && is_type_in_list(O,output_linkable))

/obj/machinery/computer/general_air_control/large_tank_control/isLinkedWith(obj/O)
	if(O:id_tag == input_tag)
		return 1
	if(O:id_tag == output_tag)
		return 1
	return 0

/obj/machinery/computer/general_air_control/supermatter_core
	icon = 'icons/obj/computer.dmi'
	frequency = 1438
	var/input_tag
	var/output_tag
	var/list/input_info
	var/list/output_info
	var/input_flow_setting = 700
	var/pressure_setting = 100
	circuit = /obj/item/weapon/circuitboard/air_management/supermatter_core

/obj/machinery/computer/general_air_control/supermatter_core/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	user.set_machine(src)

	var/list/data = list()
	var/sensors_ui[0]
	if(sensors.len)
		for(var/id_tag in sensors)
			var/long_name = sensors[id_tag]
			var/list/sensor_data = sensor_information[id_tag]
			sensors_ui[++sensors_ui.len] = list("long_name" = long_name, "sensor_data" = sensor_data)
	else
		sensors_ui = null

	data["sensors"] = sensors_ui
	data["core"] = 1

	if(input_info)
		data["input_info"] = list("power" = input_info["power"], "volume_rate" = round(input_info["volume_rate"], 0.1))
	else
		data["input_info"] = null
	if(output_info)
		data["output_info"] = list("power" = output_info["power"], "pressure_limit" = output_info["external"])
	else
		data["output_info"] = null

	data["input_flow_setting"] = round(input_flow_setting, 0.1)
	data["pressure_setting"] = pressure_setting

	ui = SSnanoui.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "atmo_control.tmpl", name, 650, 500)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(5)

/obj/machinery/computer/general_air_control/supermatter_core/receive_signal(datum/signal/signal)
	if(!signal || signal.encryption) return

	var/id_tag = signal.data["tag"]

	if(input_tag == id_tag)
		input_info = signal.data
	else if(output_tag == id_tag)
		output_info = signal.data
	else
		..(signal)

/obj/machinery/computer/general_air_control/supermatter_core/Topic(href, href_list)
	if(..())
		return 1

	if(href_list["adj_pressure"])
		var/change = text2num(href_list["adj_pressure"])
		pressure_setting = between(0, pressure_setting + change, 10*ONE_ATMOSPHERE)
		return 1

	if(href_list["adj_input_flow_rate"])
		var/change = text2num(href_list["adj_input_flow_rate"])
		input_flow_setting = between(0, input_flow_setting + change, ATMOS_DEFAULT_VOLUME_PUMP + 500) //default flow rate limit for air injectors
		return 1

	if(!radio_connection)
		return 0
	var/datum/signal/signal = new
	signal.transmission_method = TRANSMISSION_RADIO //radio signal
	signal.source = src
	if(href_list["in_refresh_status"])
		input_info = null
		signal.data = list ("tag" = input_tag, "status" = 1)
		. = 1

	if(href_list["in_toggle_injector"])
		input_info = null
		signal.data = list ("tag" = input_tag, "power_toggle" = 1)
		. = 1

	if(href_list["in_set_flowrate"])
		input_info = null
		signal.data = list ("tag" = input_tag, "set_volume_rate" = "[input_flow_setting]")
		. = 1

	if(href_list["out_refresh_status"])
		output_info = null
		signal.data = list ("tag" = output_tag, "status" = 1)
		. = 1

	if(href_list["out_toggle_power"])
		output_info = null
		signal.data = list ("tag" = output_tag, "power_toggle" = 1)
		. = 1

	if(href_list["out_set_pressure"])
		output_info = null
		signal.data = list ("tag" = output_tag, "set_external_pressure" = "[pressure_setting]", "checks" = 1)
		. = 1

	signal.data["sigtype"]="command"
	radio_connection.post_signal(src, signal, radio_filter = RADIO_ATMOSIA)

/obj/machinery/computer/general_air_control/fuel_injection
	icon = 'icons/obj/computer.dmi'
	icon_screen = "alert:0"
	var/device_tag
	var/list/device_info
	var/automation = 0
	var/cutoff_temperature = 2000
	var/on_temperature = 1200
	circuit = /obj/item/weapon/circuitboard/air_management/injector_control

/obj/machinery/computer/general_air_control/fuel_injection/process()
	if(automation)
		if(!radio_connection)
			return 0

		var/injecting = 0
		for(var/id_tag in sensor_information)
			var/list/data = sensor_information[id_tag]
			if(data["temperature"])
				if(data["temperature"] >= cutoff_temperature)
					injecting = 0
					break
				if(data["temperature"] <= on_temperature)
					injecting = 1

		var/datum/signal/signal = new
		signal.transmission_method = TRANSMISSION_RADIO //radio signal
		signal.source = src

		signal.data = list(
			"tag" = device_tag,
			"power" = injecting,
			"sigtype"="command"
		)

		radio_connection.post_signal(src, signal, radio_filter = RADIO_ATMOSIA)

	..()

/obj/machinery/computer/general_air_control/fuel_injection/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	user.set_machine(src)

	var/list/data = list()
	var/sensors_ui[0]
	if(sensors.len)
		for(var/id_tag in sensors)
			var/long_name = sensors[id_tag]
			var/list/sensor_data = sensor_information[id_tag]
			sensors_ui[++sensors_ui.len] = list("long_name" = long_name, "sensor_data" = sensor_data)
	else
		sensors_ui = null

	data["sensors"] = sensors_ui
	data["fuel"] = 1
	data["automation"] = automation

	if(device_info)
		data["device_info"] = list("power" = device_info["power"], "volume_rate" = device_info["volume_rate"])
	else
		data["device_info"] = null

	ui = SSnanoui.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "atmo_control.tmpl", name, 650, 500)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(5)

/obj/machinery/computer/general_air_control/fuel_injection/receive_signal(datum/signal/signal)
	if(!signal || signal.encryption) return

	var/id_tag = signal.data["tag"]

	if(device_tag == id_tag)
		device_info = signal.data
	else
		..(signal)

/obj/machinery/computer/general_air_control/fuel_injection/Topic(href, href_list)
	if(..())
		return

	if(href_list["refresh_status"])
		device_info = null
		if(!radio_connection)
			return 0

		var/datum/signal/signal = new
		signal.transmission_method = TRANSMISSION_RADIO //radio signal
		signal.source = src
		signal.data = list(
			"tag" = device_tag,
			"status" = 1,
			"sigtype"="command"
		)
		radio_connection.post_signal(src, signal, radio_filter = RADIO_ATMOSIA)

	if(href_list["toggle_automation"])
		automation = !automation

	if(href_list["toggle_injector"])
		device_info = null
		if(!radio_connection)
			return 0

		var/datum/signal/signal = new
		signal.transmission_method = TRANSMISSION_RADIO //radio signal
		signal.source = src
		signal.data = list(
			"tag" = device_tag,
			"power_toggle" = 1,
			"sigtype"="command"
		)

		radio_connection.post_signal(src, signal, radio_filter = RADIO_ATMOSIA)

	if(href_list["injection"])
		if(!radio_connection)
			return 0

		var/datum/signal/signal = new
		signal.transmission_method = TRANSMISSION_RADIO //radio signal
		signal.source = src
		signal.data = list(
			"tag" = device_tag,
			"inject" = 1,
			"sigtype"="command"
		)

		radio_connection.post_signal(src, signal, radio_filter = RADIO_ATMOSIA)