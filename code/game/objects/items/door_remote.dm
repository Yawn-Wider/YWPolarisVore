#define REMOTE_OPEN "Open Door"
#define REMOTE_BOLT "Toggle Bolts"
#define REMOTE_EMERGENCY "Toggle Emergency Access"

/obj/item/weapon/door_remote
    icon_state = "gangtool-white"
    item_state = "electronic"
    icon = "icons/obj/door_remote_icons.dmi"
    name = "door remote"
    desc = "remotely controls airlocks"
    var/mode = REMOTE_OPEN
    var/obj/item/weapon/card/ID
    var/datum/job/remote_access = "Assistant"

/obj/item/weapon/door_remote/new()
    ..()
    ID = new /obj/item/weapon/card/
    ID.access = door_remote.get_access()

/obj/item/weapon/door_remote/Destroy()
    QDELL_NULL(ID)
    return ..()

/obj/item/weapon/door_remote/attack_self(mob/user)
    switch(mode)
        if(REMOTE_OPEN)
            mode = REMOTE_BOLT
        if(REMOTE_BOLT)
            mode = REMOTE_OPEN // replace to "Emergency" when implemented
        /* 
            if(REMOTE_EMERGENCY)
            mode = REMOTE_OPEN
        */
    to_chat(user, "Now in mode: [mode].")

/obj/item/weapon/door_remote/afterattack(obj/machinery/doors/airlock/D, mob/user)
    if(!istype(D))
        return
    if(D.is_special)
        to_chat(user, "<span class='danger'>[src] cannot access this kind of door!</span>")
        return
    if(!(D.arePowerSystemsOn())
        to_chat(user, "<span class='danger'>[src] has no power!</span>")
        return
    if(D.checkAccess(ID)) // check to see if opener has the appropriate access in door remote. If so, do something!
        switch(mode)
            if(REMOTE_OPEN)
                if(D.checkAccess(src.ID))
                    switch(mode)
                        if(REMOTE_OPEN)
                            if(D.density)
                                D.open()
                            else
                                D.close()
                        if(REMOTE_BOLT)
                            if(D.locked)
                                D.unbolt()
                            else
                                D.bolt()
                        /*
                        if(REMOTE_EMERGENCY)
                            if(D.emergency)
                                D.emergency = 0
                            else
                                D.emergency = 1
                            D.update_icon()
                        */
    else
        to_chat(user, "<span class='danger'>[src] does not have access to this door. </span>")

/obj/item/weapon/door_remote/omni
    name = "Omni door remote"
    desc = "This remote can access any door on the station"
    icon_state = "gangtool-yellow"
    remote_access = "All" // determine if this is the appropriate defines

/obj/item/weapon/door_remote/captain
    name = "Colony Directors' Door Remote"
    icon_state = "gangtool-yellow"
    remote_access = "Captain"

/obj/item/weapon/door_remote/head_of_personel
    name = "Head of Personnels' Door Remote"
    icon_state = "gangtool-white"
    remote_access = "Head Of Personnel"

/obj/item/weapon/door_remote/chief_engineer
    name = "Chief Engineers' Door Remote"
    icon_state = "gangtool-orange"
    remote_access = "Chief Engineer"

/obj/item/weapon/door_remote/research_director
    name = "Research Directors' Door Remote"
    icon_state = "gangtool-purple"
    remote_access = "Research Director"

/obj/item/weapon/door_remote/head_of_security
    name = "Head of Securitys' Door Remote"
    icon_state = "gangtool-red"
    remote_access = "Head of Security"

/obj/item/weapon/door_remote/chief_medical_officer
    name = "Chief Medical Officers' Door Remote"
    icon_state = "gangtool-blue"
    remote_access = "Chief Medical Officer"

/obj/item/weapon/door_remote/quartermaster
    name = "Quartermasters' Door Remote"
    icon_state = "gangtool-green"
    remote_access = "Quartermaster"

#undef REMOTE_OPEN
#undef REMOTE_BOLT
#undef REMOTE_EMERGENCY