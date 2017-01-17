# Vimcastle TODO

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
* [ ] Levels (+ warningsin scene changes)
* [ ] Keys (required to proceed to other scenes)
* [ ] Actually populate all this
* [ ] Bestiary

## Refactors

* [ ] Extract hit dmg logic
* [ ] Allow multiple randomized logs per event
* [ ] state.write to process %e etc (currently concatenated in fight, partially implemented in event)
* [ ] Documentation
* [ ] Add tests for extracted utils
* [ ] Allow help anywhere
* [ ] README for non-vim users?
* [ ] Review colors
