let s:WeaponClass = {}

function! vimcastle#weapon#create(shortname, dmgmin, dmgmax) abort
	let weapon = copy(s:WeaponClass)
	let weapon.name = { 'short': a:shortname }
	let weapon.dmg = { 'min': a:dmgmin, 'max': a:dmgmax }
	return weapon
endfunction

function! s:WeaponClass.computehitdmg() dict abort
endfunction
