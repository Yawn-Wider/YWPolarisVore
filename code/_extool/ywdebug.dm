//NSV13 Memory Profiler Extension
/proc/dump_memory_profile(file_name)
	return call(EXTOOLS, "dump_memory_usage")(file_name) == EXTOOLS_SUCCESS

/client/proc/dump_memory_usage()
	set name = "Dump Server Memory Usage"
	set category = "Server"

	if (!check_rights(R_SERVER))
		return

	if (alert(usr, "This will momentarily block the server. Proceed?", "Alert", "Yes", "No") != "Yes")
		return

	var/fname = "[time2text(world.timeofday, "MM-DD-hhmm")].json"

	to_chat(world, "<span class='userdanger'>The server will momentarily freeze in 2 seconds!</span>")
	message_admins("[usr] has initiated a memory dump into \"[fname]\".")
	log_admin("[usr] has initiated a memory dump into \"[fname]\".")

	sleep(20)

	if (!dump_memory_profile("data/logs/memory/[fname]"))
		to_chat(usr, "<span class='userdanger'>Dumping memory failed at dll call.</span>")
		return

	if (!fexists("data/logs/memory/[fname]"))
		to_chat(usr, "<span class='userdanger'>File creation failed. Please check to see if the data/logs/memory folder actually exists.</span>")
	else
		to_chat(usr, "<span class='notice'>Memory dump completed.</span>")