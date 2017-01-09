let s:CharacterClass = {}

function! vimcastle#character#create(longname, shortname, health) abort
	let instance = copy(s:CharacterClass)
	let instance.name = {
				\ 'long': a:longname,
				\ 'short': a:shortname
				\ }
	let instance.health = {
				\ 'current': a:health,
				\ 'max': a:health
				\ }
	return instance
endfunction
