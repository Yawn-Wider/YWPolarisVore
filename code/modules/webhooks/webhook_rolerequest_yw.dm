/decl/webhook/rolerequest
	id = WEBHOOK_ROLEREQUEST

/decl/webhook/rolerequest/get_message(var/list/data)
	.= ..()
	.["embeds"] = list(list(
		"title" = "[data["name"]]",
		"description" = data["body"],
		"color" = COLOR_WEBHOOK_DEFAULT
	))
