let s:WeaponClass = {}

function! vimcastle#weapon#create() abort
	let instance = copy(s:WeaponClass)
	return instance
endfunction

function! vimcastle#weapon#equippable(shortname, dmgmin, dmgmax)
	let weapon = #vimcastle#weapon#create()
	weapon.name = { 'short': shortname }
	weapon.dmg = { 'min': 1, 'max': 2 }
	return weapon
endfunction

function! s:WeaponClass.add() dict abort
endfunction
