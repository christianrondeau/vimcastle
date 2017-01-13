let s:WeapongenClass = {}

function! vimcastle#weapongen#create(shortname, longname, dmgmin, dmgmax) abort
	let weapongen = copy(s:WeapongenClass)
	let weapongen.basename = { 'short': a:shortname, 'long': a:longname }
	let weapongen.basedmg = { 'min': a:dmgmin, 'max': a:dmgmax }
	return weapongen
endfunction

function! s:WeapongenClass.prefix(probabilities, prefixshort, prefixlong, mindmgmodifier, maxdmgmodifier) dict abort
	if(!exists('self.prefixes'))
		let self.prefixes = vimcastle#repository#create()
	endif
	call self.prefixes.add(a:probabilities, { 'short': a:prefixshort, 'long': a:prefixlong, 'min': a:mindmgmodifier, 'max': a:maxdmgmodifier })
	return self
endfunction

function! s:WeapongenClass.weapongen(weapongen) dict abort
	let self.weapongen = a:weapongen
	return self
endfunction

function! s:WeapongenClass.invoke() dict abort
	let name = { 'short': self.basename.short, 'long': self.basename.long }
	let dmg = copy(self.basedmg)
	if(exists('self.prefixes'))
		let prefix = self.prefixes.rnd()
		let name.short = prefix.short . ' ' . name.short
		let name.long = prefix.long . ' ' . name.long
		let dmg.min += prefix.min
		let dmg.max += prefix.max
	endif
	return vimcastle#weapon#create(name.short, name.long, dmg.min, dmg.max)
endfunction
