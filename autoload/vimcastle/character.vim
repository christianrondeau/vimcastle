let s:CharacterClass = {}

function! vimcastle#character#create(name, health) abort
	call vimcastle#utils#validate(a:name.short, 1)
	call vimcastle#utils#validate(a:name.long, 1)
	let character = copy(s:CharacterClass)
	let character.name = a:name
	let character.health = {
				\ 'current': a:health,
				\ 'max': a:health
				\ }
	let character.equipment = {}
	return character
endfunction

function! s:CharacterClass.equip(slot, item) dict abort
	let self.equipment[a:slot] = a:item
	return self
endfunction

function! s:CharacterClass.equipweapon(weapon) dict abort
	call vimcastle#utils#validate(a:weapon.name.short, 1)
	call vimcastle#utils#validate(a:weapon.stats.dmg.min, 0)
	call self.equip('weapon', a:weapon)
	return self
endfunction

function! s:CharacterClass.equiparmor(armor) dict abort
	call vimcastle#utils#validate(a:armor.name.short, 1)
	call vimcastle#utils#validate(a:armor.stats.def.min, 0)
	call self.equip('armor', a:armor)
	return self
endfunction
