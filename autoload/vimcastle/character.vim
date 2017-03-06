let s:CharacterClass = {}

function! vimcastle#character#create(name, health) abort
	call vimcastle#utils#validate(a:name.short, 1)
	call vimcastle#utils#validate(a:name.long, 1)
	let character = copy(s:CharacterClass)
	let character.name = a:name
	let character.basehealth = a:health
	let character.health = a:health
	let character.equipment = {}
	let character.level = 0
	let character.xp = 0
	let character.stats = {}
	return character
endfunction

" Equip {{{

function! s:CharacterClass.equip(item) dict abort
	let self.equipment[a:item.slot] = a:item
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

function! s:CharacterClass.getmaxhealth() dict abort
	return self.basehealth + self.getstat('con', 1) * 5
endfunction

" }}}

" Items {{{

function! s:CharacterClass.pickup(item) dict abort
	if(!exists('self.items'))
		let self.items = []
	endif
	call add(self.items, a:item)
	return self
endfunction

" }}}
