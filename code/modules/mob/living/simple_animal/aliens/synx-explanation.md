# The synx mob

The synx mob has quite a few things of interest, the first main thing is a custom variabled called `"memorysize"`
Memorysize is a variable setting the maximum amount the "speak" list is allowed to have.

In code this is handled through what i call speechcode, a small amount of code that is called on whenever the mob hears something say something.

```C
/mob/living/simple_animal/retaliate/synx/pet/hear_say(message)
	. = ..()
	if(!message)    return
	if(message)
		if(speak.len>=memorysize)
			speak -= (pick(speak))//making the list more dynamic
	speak += message
```

*For an explanation on -= and += refer to the byond reference on the topic of lists.*

In this code I also implemented a little bandaid fix for an issue mobs usually have, which is that once they are pinned to the ground meaning they enter `"resting=1"` they simple do not have code to stand back up, causing neutral mobs to become unablöe to defend themselves.

The code to go arround that I implemeneted is simply 
```C
	if(resting)
		resting = !resting
```
Which is called upon within speechcode, unresting the mob if it is rested, this can be triggered by someone talking or it itself talking.

Additionally to this Synxes have a few Passive as well as active abilities.
* Contort, contort is a modified hide proc which also slows down the user
* Toggle Form, form toggle is a integrated but currently not used ability for swapping stance, which also changes some stats.
* Poison, Synx code reuses Spider poison code to deliver their own special toxin called synxchem into a person.
All three of these can be found under the PASSIVE POWERS and POWERS section of the code in `synx.dm`

### The VORE section!

Now Vore wise Synxes actually make use of two diferent systems and that for good reason.

The first system is the basic vore setup which goes as follows
```C
	vore_active = 1 // this enables the mob from having vore interactions
	vore_capacity = 2 //Self explanatory, how many people can be in this nerd
	vore_pounce_chance = 50 // Pounce is the chance that the mob when attacking will instead try to consume, it's unit is equal to %
	vore_bump_chance = 10 //Bump is the thing that happens when a mob moves onto your tile or pushes you off it, once again % unit.
	vore_bump_emote = "Slowly wraps its tongue around, and slides its drooling maw over the head of" //The message displayed when initiating a vore
	vore_standing_too = 1 //As we understand it this enables the mob to devour standing people too, the name seems to agree.
	vore_ignores_undigestable = 0 // This means that if someone can not be digested the mob will still eat them, they cant digest them but they will still consume them eitherway, such nice endo friendos
	vore_default_mode = DM_HOLD //Here we set the mode the belly will be in by default, HOLD being the hold mode and DM_DIGEST etc being their respective modes
	vore_digest_chance = 45	 // Chance to switch to digest mode if resisted, pretty simple still a % unit.
	vore_absorb_chance = 0 //same as above but instead of for digestion its for absorbtion
	vore_escape_chance = 10 // % escape chance
	vore_icons = 0 //refer to the documentation within code/modules/mob/vore-icons.md
	swallowTime = 6 SECONDS // The amount of time a mob takes to devour you.
```

Since this is a pretty long code snippet all my comments on it are inside the above snippet formatted how you would inside the code.

The second part is used within a proc and sets up more special things about the stomach such as digestion rates, fluff text etc

```C
/mob/living/simple_animal/retaliate/synx/init_vore()
	..()
	var/obj/belly/B = vore_selected
	B.vore_verb = "swallow"
	B.name = "stomach"
	B.desc	= "You're pulled into the snug stomach of the synx."
	B.digest_burn = 1
	B.digest_brute = 0
	B.emote_lists[DM_HOLD] = list(
	"The walls churn around you",
	"The unusually cool stomach rolls around you slowly and lazily.",
	"The thick, viscous fluids cling to your body soaking in deep."
	)
	B.emote_lists[DM_DIGEST] = list(
	"The stomach kneads roughly around you.",
	"Firm churns of the stomach roll and knead you around.",
	"Your body tingles and the air smells strongly of acid.",
	"You're jostled in the stomach as the synx lets out what can only described as an alien belch."
	)
	B.digest_messages_prey = list(
	"Your eyes grow heavy as the air grows thin in the stomach.",
	"Slowly, the stinging and burning of the acids, and the constant churning is just too much.",
	"The acids and fluids rise up above your head, quickly putting an end to your squirming and conciousness.",
	"The synx lets out an audible belch, the last of your air going with it."
	)
```
I simplified a lot of the texts for the sake of keeping it a bit shorter, the names of the variables like "digest message prey" should be self explanatory.

This however is only the first part of it the second part for the PET version is as follows and more interesting for us.
```C
/mob/living/simple_animal/retaliate/synx/pet/init_vore()
    ..()
    var/obj/belly/B = vore_selected
    B.vore_verb = "swallow"
    B.digest_burn = 1
    B.digest_brute = 0
```
This is the code equivelant of the normal VORE panel we all know where you set how much damage your stomach deals as well as what word is used for the consumption text There's a bunch more that can be set and for this refer to the procs dm file found here `code/modules/mob/living/simple_animal/simple_animal_vr.dm`
