/obj/structure/reagent_dispensers/beerkeg/vat
	name = "Beer vat"
	desc = "A vat of beer."
	icon = 'icons/obj/objects.dmi'
	icon_state = "vat"
	amount_per_transfer_from_this = 15
	anchored = 1

/obj/structure/reagent_dispensers/beerkeg/vat/Initialize()
	. = ..()
	reagents.add_reagent("beer",1000)

/obj/structure/reagent_dispensers/winevat
	name = "Wine vat"
	desc = "A vat of wine."
	icon = 'icons/obj/objects.dmi'
	icon_state = "vat"
	amount_per_transfer_from_this = 10
	anchored = 1

/obj/structure/reagent_dispensers/winevat/Initialize()
	..()
	reagents.add_reagent("wine",1000)


/obj/structure/reagent_dispensers/beerkeg/fakenuke
	name = "nuclear beer keg"
	desc = "A beer keg in the form of a nuclear bomb! An absolute blast at parties!"
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "nuclearbomb0"