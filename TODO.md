# Vimcastle TODO

## Game

* [ ] Monster drops
* [ ] Usable items (hurt enemy)
* [ ] Pickup stuff (show equip. diff)
* [ ] More effects (hurt and potentially die, win XP and potentially level up)
* [ ] con (health), wil (interrupt), spi (magic str)
* [ ] Create character (name, assign stats)
* [ ] Bonus scenes (e.g. +str)
* [ ] Tutorial (predetermined seq. of events) + Test that plays a complete game incl. menu
* [ ] High scores
* [ ] Spells (?) - multi turn casting + interruptions
* [ ] XP and levels (+ warnings in scene changes and enemy fights)
* [ ] Bosses
* [ ] Keys (required to proceed to other scenes)
* [ ] Actually populate all this
* [ ] Flee combat
* [ ] Bestiary
* [ ] Save/Load game. Remember only scene and player state. Overwrite on `q`

## Refactors

* [ ] Make the slot part of equippable instead of .equip
* [ ] Are event name useful?
* [ ] Use same label/name
* [ ] Unlet enemy if continue in event
* [ ] Deal w/ max inventory
* [ ] Add tests for final stats
* [ ] Run vint in travis
* [ ] Prepend `l:`
* [ ] Provide a color scheme for numbers (damage, stats, etc.)
* [ ] Avoid duplicating short names
* [ ] Review colors
* [ ] README for non-vim users?
* [ ] Test each monster against matching player lvl
* [ ] Contributing guide explaining vader/vint, concepts, terminology etc.
* [ ] Increase probability of repo every turn, reset on hit

## Ideas

* [ ] Custom text per weapon (slash, crush, aim and fire...)
* [ ] Special monsters / weapons / scenes with ASCII art (and animations?)
* [ ] Scene can depend on you being (str)ong enough, etc.
* [ ] "Animation" when selecting an action (transitions), e.g. highlight the option, shake, flash, etc.
* [ ] Auto combat (skip)
* [ ] Character class? (May provide special bonuses)
* [ ] Scenes that draw health (e.g. no air, burning floor)
* [ ] Teleport scroll
* [ ] Enchant weapon
* [ ] Steal items (events, monsters)
* [ ] Temp. effects (e.g. poison hurts, blind hides logs)
* [ ] Temp. buffs (e.g. boost strength)
* [ ] Create your own character
* [ ] Special unique skills (block one hit, steal items  fastrr xp)
* [ ] Map of discovered areas and links
* [ ] Fast travel to previously discovered areas
* [ ] Weapon 'of Light', 'of the King' etc w/ special bonuses like heal, dbl attack, etc
* [ ] Add strategic elements and make the game enjoyable
* [ ] The Void (scene with nothing)

