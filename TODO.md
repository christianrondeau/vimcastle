# Vimcastle TODO

## Game

* [ ] Show when new high score
* [ ] Use item should not use when health full
* [ ] Save/Load game. Remember only scene and player state. Overwrite on `q`
* [ ] Animations: Fight (hurt), action
* [ ] Increase probabilities over time
* [ ] Max inventory / drop items
* [ ] Usable items (hurt enemy)
* [ ] More effects (hurt and potentially die, win XP and potentially level up, gain stats e.g. +def, +dex, +con)
* [ ] Allow specifying a 'next event' (e.g. after a boss, or logical sequence)
* [ ] Create some content

## Refactors

* [ ] Rename tests/state to states
* [ ] Remove line/col indicators in bash-invoked vim
* [ ] Directly invoke action_something on the event instead of implementing .action()
* [ ] Never use game.nextaction; instead decide which event id to invoke
* [ ] Gens folder
* [ ] Confusion between the game.screen that represents which state, and screens which are ui renderers
* [ ] Create a log utility to hide complexity away from game
* [ ] Test all monsters w/ level (max dmg, max def, etc)
* [ ] Are event name useful?
* [ ] Avoid duplicating short names
* [ ] Unlet enemy if continue in fight event
* [ ] Increase probability of repo every turn, reset on hit
* [ ] Provide a color scheme for numbers (damage, stats, etc.) and review all colors
* [ ] README for non-vim users?
* [ ] Contributing guide explaining vader/vint, concepts, terminology etc.

## Backlog

* [ ] Auto combat (skip)
* [ ] Show dmg, hit %, flee% in fight
* [ ] Custom text per weapon (slash, crush, aim and fire...)
* [ ] Teleport scroll
* [ ] Scene can depend on you being (str)ong enough, etc.
* [ ] Tutorial (predetermined seq. of events) + Test that plays a complete game incl. menu
* [ ] Flee combat
* [ ] Spells (?) - multi turn casting + interruptions
* [ ] wil (interrupt), spi (magic str)
* [ ] Character class? (May provide special bonuses)
* [ ] Create character (name, assign stats)
* [ ] Keys (required to proceed to other scenes)
* [ ] Monster drops
* [ ] Special monsters / weapons / scenes with ASCII art (and animations?)
* [ ] Bestiary
* [ ] Settings: animations, font, colors, show intro...
* [ ] Enchant weapon
* [ ] Steal items (events, monsters)
* [ ] Temp. effects (e.g. poison hurts, blind hides logs)
* [ ] Temp. buffs (e.g. boost strength)
* [ ] Special unique skills (block one hit, steal items  fastrr xp)
* [ ] Map of discovered areas and links
* [ ] Fast travel to previously discovered areas
* [ ] Weapon 'of Light', 'of the King' etc w/ special bonuses like heal, dbl attack, etc
* [ ] Add strategic elements and make the game enjoyable
* [ ] The Void (scene with nothing)

## Refactors

* [ ] Run vint in travis
* [ ] Prepend `l:`
