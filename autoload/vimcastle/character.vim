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
	let character.stats = {}
	let character.equipment = {}
	return character
endfunction

" Equip {{{

function! s:CharacterClass.equip(slot, item) dict abort
	let self.equipment[a:slot] = a:item
	return self
endfunction

function! s:CharacterClass.equipweapon(weapon) dict abort
	call vimcastle#utils#validate(a:weapon.name.short, 1)
	call vimcastle#utils#validate(a:weapon.dmg.min, 0)
	call self.equip('weapon', a:weapon)
	return self
endfunction

function! s:CharacterClass.equiparmor(armor) dict abort
	call vimcastle#utils#validate(a:armor.name.short, 1)
	call vimcastle#utils#validate(a:armor.stats.def, 0)
	call self.equip('armor', a:armor)
	return self
endfunction

" }}}

" Stats {{{

function! s:CharacterClass.getstat(name, combined) dict abort
	let value = get(self.stats, a:name, 0)
	if a:combined
		for slot in keys(self.equipment)
			let item = self.equipment[slot]
			let value += get(item.stats, a:name, 0)
		endfor
	endif
	return value
endfunction

function! s:CharacterClass.setstat(name, value) dict abort
	let self.stats[a:name] = a:value
	return self
endfunction

function! s:CharacterClass.setstats(stats) dict abort
	for name in keys(a:stats)
		let self.stats[name] = a:stats[name]
	endfor
	return self
endfunction

" }}}
