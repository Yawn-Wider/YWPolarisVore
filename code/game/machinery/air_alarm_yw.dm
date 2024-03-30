/obj/machinery/alarm/yw/Initialize(mapload)
	. = ..()
	if(!pixel_x && !pixel_y)
		offset_airalarm()
	first_run_yw()

/obj/machinery/alarm/yw/proc/first_run_yw()
	alarm_area = get_area(src)
	area_uid = "\ref[alarm_area]"
	if(name == "alarm")
		name = "[alarm_area.name] Air Alarm"

	if(!wires)
		wires = new(src)

	// breathable air according to human/Life()
	TLV["oxygen"] =			list(16, 19, 135, 140) // Partial pressure, kpa
	TLV["nitrogen"] =		list(0, 0, 135, 140) // Partial pressure, kpa
	TLV["carbon_dioxide"] = list(-1.0, -1.0, 5, 10) // Partial pressure, kpa
	TLV["phoron"] =			list(-1.0, -1.0, 0, 0.5) // Partial pressure, kpa
	TLV["other"] =			list(-1.0, -1.0, 0.5, 1.0) // Partial pressure, kpa
	TLV["pressure"] =		list(ONE_ATMOSPHERE * 0.65, ONE_ATMOSPHERE * 0.90, ONE_ATMOSPHERE * 1.10, ONE_ATMOSPHERE * 1.20) /* kpa */
	TLV["temperature"] =	list(T0C - 80, T0C, T0C + 40, T0C + 66) // K

	update_icon()

/obj/machinery/alarm/yw/nobreach
	breach_detection = 0

/obj/machinery/alarm/yw/monitor
	report_danger_level = 0
	breach_detection = 0

/obj/machinery/alarm/yw/isolation
	req_one_access = list(access_research, access_atmospherics, access_engine_equip)

/obj/machinery/alarm/yw/monitor/isolation
	req_one_access = list(access_research, access_atmospherics, access_engine_equip)
