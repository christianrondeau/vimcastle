let s:EquippablegenClass = {}

function! vimcastle#equippablegen#create(shortname, longname) abort
	let equippablegen = copy(s:EquippablegenClass)
	let equippablegen.base = {
				\  'name': { 'short': a:shortname, 'long': a:longname },
				\  'stats': {}
				\}
	return equippablegen
endfunction

function! vimcastle#equippablegen#weapon(shortname, longname, dmgmin, dmgmax) abort
	return vimcastle#equippablegen#create(a:shortname, a:longname).stat('dmg', a:dmgmin, a:dmgmax)
endfunction

function! vimcastle#equippablegen#armor(shortname, longname, def) abort
	return vimcastle#equippablegen#create(a:shortname, a:longname).stat('def', a:def, a:def)
endfunction

function! s:EquippablegenClass.stat(name, min, max) dict abort
	let stat = {}
	let stat.min = a:min
	let stat.max = a:max
	let self.base.stats[a:name] = stat
	return self
endfunction

function! s:EquippablegenClass.getprefixes() dict abort
	if(!exists('self.prefixes'))
		let self.prefixes = vimcastle#repository#create()
	endif
	return self.prefixes
endfunction

function! s:EquippablegenClass.noprefix(probabilities) dict abort
 call self.getprefixes().add(a:probabilities, {})
 return self
endfunction

function! s:EquippablegenClass.prefix(probabilities, short, long, stat, min, max) dict abort
	call self.getprefixes().add(a:probabilities, { 'short': a:short, 'long': a:long, 'stat': a:stat, 'min': a:min, 'max': a:max})
	return self
endfunction

function! s:EquippablegenClass.getsuffixes() dict abort
	if(!exists('self.suffixes'))
		let self.suffixes = vimcastle#repository#create()
	endif
	return self.suffixes
endfunction

function! s:EquippablegenClass.nosuffix(probabilities) dict abort
 call self.getsuffixes().add(a:probabilities, {})
 return self
endfunction

function! s:EquippablegenClass.suffix(probabilities, short, long, stat, min, max) dict abort
	call self.getsuffixes().add(a:probabilities, { 'short': a:short, 'long': a:long, 'stat': a:stat, 'min': a:min, 'max': a:max})
	return self
endfunction

function! s:EquippablegenClass.invoke() dict abort
	let equippable = deepcopy(self.base)

	if(exists('self.prefixes'))
		let prefix = self.prefixes.rnd()
		if(exists('prefix.short'))
			let equippable.name.short = prefix.short . ' ' . equippable.name.short
			let equippable.name.long = prefix.long . ' ' . equippable.name.long
			call s:apply(equippable, prefix)
		endif
	endif

	if(exists('self.suffixes'))
		let suffix = self.suffixes.rnd()
		if(exists('suffix.short'))
			let equippable.name.short .= ' ' . suffix.short
			let equippable.name.long .= ' ' . suffix.long
			call s:apply(equippable, suffix)
		endif
	endif

	return equippable
endfunction

function! s:apply(equippable, modifier)
	if(!has_key(a:equippable.stats, a:modifier.stat))
		let a:equippable.stats[a:modifier.stat] = { 'min': 0, 'max': 0 }
	endif
	let a:equippable.stats[a:modifier.stat].min += a:modifier.min
	let a:equippable.stats[a:modifier.stat].max += a:modifier.max
endfunction
