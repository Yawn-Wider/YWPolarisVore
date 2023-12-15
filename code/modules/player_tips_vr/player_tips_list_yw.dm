/* List of player tips
Weighted to emphasize more important over less.area
Weights are not additive. You can have multiple prob(50) items.
prob(50) makes it half as likely to appear and so forth.
When editing the list, please try and keep similar probabilities near each other. High on top, low on bottom */

//argument determines if to pick a random tip or use a forced choice.
/datum/player_tips/proc/pick_tip(var/isSpecific)
	var/choice = null
	if(!(isSpecific == "none" || isSpecific == "general" || isSpecific == "gameplay" || isSpecific == "roleplay" || isSpecific == "lore" ))
		choice = "none" //Making sure that wrong arguments still give tips.
	if(isSpecific == "none")
		choice = pick (
			prob(50); "gameplay",
			prob(40); "general",
			prob(40); "roleplay",
			prob(20); "lore"
		)
	else
		choice = isSpecific

	switch(choice)
		if("general")
			var/info = "The following is a general tip to playing on Yawn-Wider! \n"
			return pick(
				/* prob(60); "[info] Got a question about gameplay, roleplay or the setting? Press F1 to Mentorhelp!", we dont really have mentors */
				prob(60); "[info] We have a wiki which contains a few server specific pages including some lore, Please check it out at https://yawn.izac.live/Main_Page for mechanics undocumented at our wiki Please check it out at https://wiki.vore-station.net/Main_Page for help!",
				prob(60); "[info] Unsure about rules? Press F1 and ask our admins for clarification - they are happy to help.",
				prob(50); "[info] To make this server fun for all types enjoyment, including conflicting desires, ERP is allowed but cannot be done near non-consenting people. If caught ERPing ICly, one can be arrested for public indecency, be mindful of those around you! https://yawn.izac.live/Server_Rules",
				prob(35); "[info] Our discord is an excellent resource to stay up to date about changes and events!",
				prob(35); "[info] Encountered what seems like a bug? Even if uncertain, feel free to go ahead and report it at https://github.com/Yawn-Wider/YWPolarisVore/issues !",
				prob(30); "[info] Having difficulties getting started? Pressing F3 to speak and typing '; Hello! I'm a new hire. Could someone please give me a tour?' or as appropriate for your character is a good way to start! More help available at: https://wiki.vore-station.net/The_Basics",
				prob(30); "[info] Building a custom-species, or just trying to spice up a canon one? Take a look at our possible traits at https://wiki.vore-station.net/Traits",
				prob(30); "[info] Don't be afraid to approach your fellow players for advice! Learning things ICly can help build powerful bonds!",
				/* prob(30); "[info] Need some guideance making a character or with roleplay concepts? Our discord's Cadet-Academy and Lore channels are happy to help!", TODO rewrite */
				prob(30); "[info] Want to try out a new department? Consider joining as an intern when it's well-staffed. Some players enjoy teaching eager students. You can approach such roleplay as simply getting taught the local technologies, procedures - you don't need to be 'fresh out of school' to justify it!",
				prob(5); "[info] Got another tip for the list? Please let us know on Discord/Dev-suggestions!"
			)


		if("gameplay")
			var/info = "The following is a gameplay-focused tip to playing on Yawn-Wider \n"
			return pick(
				prob(50); "[info] To talk to your fellow coworkers, use ';'! You may append it by an exclamation mark, like ';!' to perform an audiable emote. ",
				prob(50); "[info] Lost on the map? You can find In-Character help by speaking on the Common Radio. You can do this by pressing F3 and typing ' ; ' before your message. Your fellow co-workers will likely help. If OOC help is preferred just ask! ",
				prob(50); "[info] You may set your suit sensors by clicking on the icon in the bottom left corner, then right click the clothes that appear right above it. It is recommended to turn on suit sensors to 'TRACKING' before doing anything dangerous like mining.",
				prob(35); "[info] You can insert your I.D into your PDA. This frees up your belt from having to carry your PDA. Furthermore, by clicking and dragging the PDA to game screen, you can use it without holding it!",
				prob(35); "[info] It is never a bad idea to visit the medbay if you get injured - small burns and cuts can get infected and become harder to treat! Alternatively, bathrooms and the bar often has a NanoMed on the wall - with ointments to disinfect cuts and burns, bandages to treat bruises and encourage healing.",
				prob(35); "[info] Your vore-bellies have multiple add-ons! Muffling is excellent to ensure your prey does not accidentally inform everyone about their predicament, and jam suit sensors is a great courtesy to avoid medical being worried about your prey!",
				prob(25); "[info] Two control modes exist for SS13 - hotkey ON and hotkey OFF. You can swap between the two modes by pressing TAB. In hotkey mode, to chat you need to press T to say anything which creates a small talking bubble. You can consult our list of hotkeys at https://wiki.vore-station.net/Keyboard_Shortcuts",
				prob(25); "[info] Do you want to shift your character around, for instance to appear as if leaning on the wall? Press CTRL + SHIFT + arrow keys to do so! Moving resets this.",
				prob(25); "[info] Emergency Fire Doors  seal breaches and keep active fires out. Please do not open them without good reason.",
				prob(25); "[info] The kitchen's Oven can fit multiple ingredients in one slot if you pull the baking tray out first.  This is required for most recipes, and the Grille and Deep Frier work the same way!",
				prob(10); "[info] You can keep a single item between rounds using secure lockboxes! Beware! You can only store 1 item across all characters!",
				prob(10); "[info] Not every hostile NPC you encounter while mining or exploring need to be defeated. Sometimes, it's better to avoid or run away from them. For example, star-treaders are slow and weak but have lots of HP - it is better to just run away."
				)

		if("roleplay")
			var/info = "The following is a roleplay-focused tip to playing on Yawn-Wider \n"
			return pick(
				prob(45); "[info] Use subtle only in cases where it would make sense. That is, in cases where other crewmembers would not be able to see what you are doing to the other person in subtle range. Do not use subtle to whisper. Subtles can however be used in Dorms and Residential at will whether the action itself is subtle or not. But only in those areas.",
				prob(40); "[info] Please avoid a character that knows everything. Having only a small set of jobs you are capable of doing can help flesh out your character! It's OK for things to break and fail if nobody is around to fix it - you do not need to do others' jobs.",
				prob(40); "[info] Just because you see something doesn't mean your character has to. A courtesy 'missing' of contraband or scene details can go a long way towards preserving everyone's fun!",
				prob(40); "[info] Embrace the limits of your character's skillsets! Seeking out other players to help you with a more challenging task might build friendships, or even lead to a scene!",
				prob(35); "[info] Slowing down when meeting another player can help with finding roleplay! Your fellow player might be typing up a greeting or an emote, and if you run off you won't see it!",
				prob(35); "[info] Having difficulty finding scenes? The number one tip that people should take for finding scenes is to be active! Generally speaking, people are more likely to interact with you if you are moving about and doing things. Sitting at a table passively might make others think you are AFK or busy!",
				prob(25); "[info] It is a good idea to wait a few moments after using mechanics like lick, hug or headpat on another player. They might be typing up a response or wish to reciprocate, and if you run away you might miss out!",
				prob(25); "[info] Participating in an away mission and see something acting strange? Try emoting or talking to it before resorting to fighting. It may be an event!",
				prob(25); "[info] It is always a good idea to communicate on your department's private channel (whose key you can learn by examining your headset) when responding to an emergency! This lets your coworkers know if they might be needed!",
				prob(25); "[info] While following the SOP is not mandatory, and you are free to break it (albeit, with potential in-character consequences), departments like security and medical do well to be familiar with them! https://yawn.izac.live/Standard_Operating_Procedure",
				prob(25); "[info] Think a player is acting especially antagonistic? It might be better to Ahelp (with F1) rather than try to deal with it icly, staff can make sure it's all okay.",
				prob(20); "[info] See a minor infraction as Security with a minimal time punishment? Consider using your ticket printer to give a non obtrusive punishment.",
				prob(15); "[info] We are a roleplay server. This does not neccessarily mean 'serious' roleplay, levity and light-hearted RP is more than welcome!",
				prob(10); "[info] Sending faxes to central command, using the 'pray' verb or pressing F1 to ahelp are highly encouraged when exploring the gateway or overmap locations! Letting GMs know something fun is happening allows them to spice things up and make the world feel alive!"
				)

		if("lore")
			var/info = "The following is tip for understanding the lore of Yawn-Wider \n"
			return pick(
				prob(50); "[info] You are currently working in the Borealis system. It is part of NanoTrasen, and quite isolated thanks to being a long distance away from any major System. https://yawn.izac.live/Cryogaia",
				prob(50); "[info] The majority of employees live at the Space Station above Cryogaia called the NCS Serenity. Most people live underground, This is the place the shuttle takes you at the end of the round. https://yawn.izac.live/Cryogaia#NCS_Serenity",
				prob(10); "[info] Borealis is very far from any civlized system, taking a minimum of a couple months of travel using bluespace drives or use of expensive Bluespace Gates to cut the time down. https://wiki.vore-station.net/Infrastructure#Bluespace_Gate",
				prob(10); "[info] Thaler is a universal currency. Its value is set to 1 second of FTL 'bluespace' travel. While ubiquitous in frontier worlds, it has an unfavourable exchange rate with most currencies used by well-settled regions, limiting immigration to places such as Earth. https://wiki.vore-station.net/Thaler",
				prob(10); "[info] Sol is where NanoTrasen is headquartered more specifclly on Luna, and they mostly follow Admiralty Law, even out in its distant colonies. https://yawn.izac.live/Admiralty_Law",
				prob(10); "[info] In certain silicon jobs or bodies there may be hard-wired functions ('laws') to limit dangerous behaviors or to encourage productivity. Remember that these are tied to the body, not the mind controlling the body!",
				prob(5); "[info] Positronic minds are valued for their resilience, self sufficiency, and resistance to tampering. Each one is comparable to a typical human mind in capability, with similar properties of memory and cognitive alacrity.",
				prob(5); "[info] Drones are much like our A.I in real life at their lower levels. At higher sophistication, they become like classic sci-fi robots. Drones' personalities can be overwritten by a skilled coder, memories tampered with.",
				prob(5); "[info] Cyborgs are organic brains in a jar. While historically, wiping their minds to use as a wetware processor had been a thing - today, its not too common."
			)
