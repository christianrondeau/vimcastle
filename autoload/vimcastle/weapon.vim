let s:WeaponClass = {}

function! vimcastle#weapon#create(shortname, longname, dmgmin, dmgmax) abort
		let weapon = copy(s:WeaponClass)
	let weapon.name = { 'short': a:shortname, 'long': a:longname }
	let weapon.dmg = { 'min': a:dmgmin, 'max': a:dmgmax }
	return weapon
endfunction

function! vimcastle#weapon#short(name, dmgmin, dmgmax) abort
	return vimcastle#weapon#create(a:name, a:name, a:dmgmin, a:dmgmax)
endfunction
