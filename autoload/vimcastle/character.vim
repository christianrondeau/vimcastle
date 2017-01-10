let s:CharacterClass = {}

function! vimcastle#character#create(longname, shortname, health, weapon) abort
	let character = copy(s:CharacterClass)
	let character.name = {
				\ 'long': a:longname,
				\ 'short': a:shortname
				\ }
	let character.health = {
				\ 'current': a:health,
				\ 'max': a:health
				\ }
	let character.weapon = a:weapon
	return character
endfunction
