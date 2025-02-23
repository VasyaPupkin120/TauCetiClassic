// overlays abuse can cause additional server and client load, so use it carefully

/obj/effect/decal/turf_decal
	name = "Turf Decals"
	icon = 'icons/turf/turf_decals.dmi'

/obj/effect/decal/turf_decal/atom_init(mapload, new_state, new_dir, new_color, new_alpha)
	. = ..()

	icon_state = new_state || icon_state

	if(!icon_state)
		CRASH("Attempt to create turf decal with no state! [x].[y].[z]")

	var/turf/T = get_turf(src)

	var/image/I = image(icon, icon_state, dir = (new_dir || dir)) // temp image to work around mutable_appearance dir problem (thx tg for this solution)

	var/mutable_appearance/MA = new(I) // todo: it creates new MA for every new decal, need to optimise reuse (i think tg did it with elements)
	MA.color = new_color || color
	MA.alpha = new_alpha || alpha
	T.add_turf_decal(MA)

	return INITIALIZE_HINT_QDEL

// It's just for quick access, feel free to varset decals with any color and alpha in map editor

// strips and text decals
/obj/effect/decal/turf_decal/alpha 
	name = "Transparent Turf Decals"
	alpha = 100

/obj/effect/decal/turf_decal/alpha/yellow
	name = "Transparent Yellow Turf Decals"
	color = "#ffff00"

/obj/effect/decal/turf_decal/alpha/cyan
	name = "Transparent Cyan Turf Decals"
	color = "#00ffff"

/obj/effect/decal/turf_decal/alpha/black
	name = "Transparent Black Turf Decals"
	color = "#000000"

/obj/effect/decal/turf_decal/alpha/red
	name = "Transparent Red Turf Decals"
	color = "#ff0000"

/obj/effect/decal/turf_decal/alpha/gray
	name = "Transparent Gray Turf Decals"
	color = "#666666"

// sidings / borders
/obj/effect/decal/turf_decal/wood
	name = "Wood Turf Decals"
	color = "#ffc500"

/obj/effect/decal/turf_decal/metal
	name = "Metal Turf Decals"
	color = "#404040"

// special decals
/obj/effect/decal/turf_decal/goonplaque
	name = "Goon Plaque"
	icon_state = "plaque" // who resprited it as Tau Ceti? Possible we lost some goon reference

/obj/effect/decal/turf_decal/goonplaque/atom_init()
	. = ..()

	// maybe not the best way, but i want to get rid of plaque-turf
	var/turf/T = get_turf(src)
	T.name = "Comemmorative Plaque";
	T.desc = "\"Это металлический диск в честь наших товарищей на станциях G4407. Недеемся, модель TG4407 сможет служить на ваше благо.\" Ниже выцарапано грубое изображение метеора и космонавта. Космонавт смеется. Метеор взрывается.";
