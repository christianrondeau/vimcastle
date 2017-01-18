# Vimcastle TODO

## Game

* [ ] Save/Load game. Remember only scene and player state. Overwrite on `q`
* [ ] Armor (reduce dmg)
* [ ] Inventory (list of items, weapon stats)
  * [ ] Potions (heal)
  * [ ] Teleport scroll
  * [ ] Enchant weapon
* [ ] The Void (scene with nothing)
* [ ] Pickup stuff (show equip. diff)
* [ ] str (dmg), dex (miss/crit), spd (first to attack), con (health), wil (interrupt), spi (magic str)
* [ ] Miss/Critical
* [ ] Attack order
* [ ] Create character (name, assign stats)
* [ ] Character sheet
* [ ] Bonus scenes (e.g. +str)
* [ ] Tutorial (predetermined seq. of events) + Test that plays a complete game incl. menu
* [ ] High scores
* [ ] Spells (?) - multi turn casting + interruptions
* [ ] XP and levels (+ warnings in scene changes and enemy fights)
* [ ] Keys (required to proceed to other scenes)
* [ ] Actually populate all this
* [ ] Flee combat
* [ ] Bestiary

## Refactors

* [ ] Extract hit dmg logic
* [ ] Allow multiple randomized logs per event
* [ ] state.write to process %e etc (currently concatenated in fight, partially implemented in event)
* [ ] Documentation
* [ ] Add tests for extracted utils
* [ ] Allow (h)elp anywhere
* [ ] Review colors
* [ ] `Vimcastle!` to run with color scheme, permanent settings and map q to quit vim
* [ ] README for non-vim users?

## Ideas

* [ ] Scenes that draw health (e.g. no air, burning floor)
* [ ] Steal items (event
* [ ] Temp. effects (e.g. poison hurts, blind hides logs)
* [ ] Temp. buffs (e.g. boost strength)
* [ ] Create your own character
* [ ] Special unique skills (block one hit, steal items  fastrr xp)
* [ ] Map of discovered areas and links
* [ ] Fast travel to previously discovered areas
* [ ] Weapon 'of Light', 'of the King' etc w/ special bonuses like heal, dbl attack, etc

