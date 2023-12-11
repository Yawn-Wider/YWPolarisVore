/*!
 * Copyright (c) 2020 Aleksej Komarov
 * SPDX-License-Identifier: MIT
 */

 /**
  * tgui state: admin_state
  *
  * Checks that the user is an admin, end-of-story.
 **/

GLOBAL_DATUM_INIT(tgui_admin_state, /datum/tgui_state/admin_state, new)

/datum/tgui_state/admin_state/can_use_topic(src_object, mob/user)
	if(check_rights_for(user.client, R_ADMIN|R_MOD|R_EVENT)) //YW Edit, make sure you have admin or mod rights to mess with player notes
		return STATUS_INTERACTIVE
	return STATUS_CLOSE
