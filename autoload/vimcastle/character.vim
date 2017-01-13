let s:CharacterClass = {}

function! vimcastle#character#create(name, health, weapon) abort
	call vimcastle#utils#validate(a:name.short, 1)
	call vimcastle#utils#validate(a:name.long, 1)
	let character = copy(s:CharacterClass)
	let character.name = a:name
	let character.health = {
				\ 'current': a:health,
				\ 'max': a:health
				\ }
	let character.weapon = a:weapon
	return character
endfunction
