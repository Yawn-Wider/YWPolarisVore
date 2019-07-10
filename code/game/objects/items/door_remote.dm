#define REMOTE_OPEN "Open Door"
#define REMOTE_BOLT "Toggle Bolts"
#define REMOTE_EMERGENCY "Toggle Emergency Access"

/obj/item/weapon/door_remote
    icon_state = "chainswordon"
    item_state = "chainswordon"
    name = "door remote"
    desc = "remotely controls airlocks"
    var/mode = REMOTE_OPEN
    var/obj/item/weapon/card/ID
    var/datum/job/remote_access = "Assistant"

/obj/item/weapon/door_remote/new()
    ..()
    ID = new /obj/item/weapon/card/
    ID.access = door_remote.get_access()

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
    user << "Now in mode: [mode]."

/obj/item/weapon/door_remote/afterattack(obj/machinery/doors/airlock/D, mob/user)
    if(!istype(D))
        return
     if(!(D.arePowerSystemsOn())
        return
    if(D.checkAccess(ID)) // check to see if opener has the appropriate access in door remote. If so, do something!
        switch(mode)
            if(REMOTE_OPEN)
                if(D.checkAccess(ID))
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

/obj/item/weapon/door_remote/captain
    name = "Colony Directors' Door Remote"
    desc = "this door remote can control any door on the station."
    remote_access = "Captain"

/obj/item/weapon/door_remote/head_of_personel
    name = "Head of Personnels' Door Remote"
    remote_access = "Head Of Personnel"

/obj/item/weapon/door_remote/chief_engineer
    name = "Chief Engineers' Door Remote"
    remote_access = "Chief Engineer"

/obj/item/weapon/door_remote/research_director
    name = "Research Directors' Door Remote"
    remote_access = "Research Director"

/obj/item/weapon/door_remote/head_of_security
    name = "Head of Securitys' Door Remote"
    remote_access = "Head of Security"

/obj/item/weapon/door_remote/chief_medical_officer
    name = "Chief Medical Officers' Door Remote"
    remote_access = "Chief Medical Officer"

/obj/item/weapon/door_remote/quartermaster
    name = "Quartermasters' Door Remote"
    remote_access = "Quartermaster"

#undef REMOTE_OPEN
#undef REMOTE_BOLT
#undef REMOTE_EMERGENCY