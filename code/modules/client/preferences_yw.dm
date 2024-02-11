/datum/preferences
	var/wingdings = 1
	var/colorblind_mono = 0
	var/colorblind_vulp = 0
	var/colorblind_taj = 0
	var/haemophilia = 1

//proc for setting disabilities
/datum/category_item/player_setup_item/general/body/proc/Disabilities_YW(mob/user)
	var/dat = "<body>"
	dat += "<html><center>"

	if(pref.species == "Grey")
		dat += "Speak Wingdings: <a href='?src=\ref[src];wingdings=1'><b>[pref.wingdings ? "Yes" : "No"]</b></a><br>"
	dat += "Needs Glasses: <a href='?src=\ref[src];disabilities=[NEARSIGHTED]'><b>[pref.disabilities & NEARSIGHTED ? "Yes" : "No"]</b></a><br>"
	if(pref.colorblind_vulp == 0 && pref.colorblind_taj == 0)
		dat += "Colorblind - Monochromacy): <a href='?src=\ref[src];colorblind_mono=1'><b>[pref.colorblind_mono ? "Yes" : "No"]</b></a><br>"
	if(pref.colorblind_mono == 0 && pref.colorblind_taj == 0)
		dat += "Colorblind - Green-Red): <a href='?src=\ref[src];colorblind_vulp=1'><b>[pref.colorblind_vulp ? "Yes" : "No"]</b></a><br>"
	if(pref.colorblind_mono == 0 && pref.colorblind_vulp == 0)
		dat += "Colorblind - Blue-Red): <a href='?src=\ref[src];colorblind_taj=1'><b>[pref.colorblind_taj ? "Yes" : "No"]</b></a><br>"
	dat += "Haemophilia: <a href='?src=\ref[src];haemophilia=1'><b>[pref.haemophilia ? "Yes" : "No"]</b></a><br>"

	dat +=  "<a href='?src=\ref[src];reset_disabilities=1'>Reset</a><br>"

	dat += "</center></html>"
	var/datum/browser/popup = new(user, "disabil", "<div align='center'>Choose Disabilities</div>", 350, 380, src)
	popup.set_content(dat)
	popup.open()


/datum/preferences/proc/export_prefs_json()
	if(!path)				return 0
	if(!fexists(path))		return 0
	var/savefile/S = new /savefile(path)
	if(!S)					return 0

	if(tgui_alert(usr, "This will save and export all your character slots and user preferences to a file. Are you sure?","Export All",list("Yes","No"))=="No")
		return

	S.cd = "/"
	var/save_json = rustg_savefile_to_json(S.ExportText())
	var/datum/browser/popup = new(usr, "saveexport", "Save Export", 350, 380, src)
	popup.set_content({"<script>
	const raw = [save_json];
	// Old browser, need to use blob builder
	window.BlobBuilder = window.BlobBuilder 	 ||
						window.WebKitBlobBuilder ||
						window.MozBlobBuilder 	 ||
						window.MSBlobBuilder;
	var blob;
	if (window.BlobBuilder) {
		var bb = new BlobBuilder();
		bb.append(JSON.stringify(raw, null, 2));
		blob = bb.getBlob("application/pdf");
	}
	else {
		window.alert("Failed to auto-download. Please copy-paste from the form in the window.");
	}

	if(blob) {
		window.navigator.msSaveOrOpenBlob(blob, "save.json");
	}
	else {
		window.alert("Failed to auto-download. Please copy-paste from the form in the window.");
	}


	</script>
	<pre>[html_encode(save_json)]</pre>
	"})
	popup.open()
