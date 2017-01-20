let s:EquippablegenClass = {}

function! vimcastle#equippablegen#create(shortname, longname) abort
	let equippablegen = copy(s:EquippablegenClass)
	let equippablegen.base = {
				\  'name': { 'short': a:shortname, 'long': a:longname },
				\  'dmg': { 'min': 0, 'max': 0 },
				\  'stats': {}
				\}
	return equippablegen
endfunction

function! vimcastle#equippablegen#weapon(shortname, longname, dmgmin, dmgmax) abort
	return vimcastle#equippablegen#create(a:shortname, a:longname)
				\.dmg(a:dmgmin, a:dmgmax)
endfunction

function! vimcastle#equippablegen#armor(shortname, longname, def) abort
	return vimcastle#equippablegen#create(a:shortname, a:longname)
				\.stat('def', a:def)
endfunction

function! s:EquippablegenClass.dmg(min, max) dict abort
	let self.base.dmg.min = a:min
	let self.base.dmg.max = a:max
	return self
endfunction

function! s:EquippablegenClass.stat(name, value) dict abort
	let self.base.stats[a:name] = a:value
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

function! s:buildmodifier(short, long, stat, value, max) abort
	let modifier = { 'short': a:short, 'long': a:long, 'stat': a:stat }
	if(a:stat ==# 'dmg')
		let modifier.min = a:value
		let modifier.max = a:max
	else
		let modifier.value = a:value
	endif
	return modifier
endfunction

function! s:EquippablegenClass.prefix(probabilities, short, long, stat, value, ...) dict abort
	call self.getprefixes().add(a:probabilities, s:buildmodifier(a:short, a:long, a:stat, a:value, a:0 > 0 ? a:1 : 0))
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

function! s:EquippablegenClass.suffix(probabilities, short, long, stat, value, ...) dict abort
	call self.getsuffixes().add(a:probabilities, s:buildmodifier(a:short, a:long, a:stat, a:value, a:0 > 0 ? a:1 : 0))
	return self
endfunction

function! s:EquippablegenClass.invoke() dict abort
	let equippable = deepcopy(self.base)

	if(exists('self.prefixes'))
		let prefix = self.prefixes.rnd()
		if(exists('prefix.short'))
			let equippable.name.short = prefix.short . ' ' . equippable.name.short
			let equippable.name.long = prefix.long . ' ' . equippable.name.long
			call s:applymodifier(equippable, prefix)
		endif
	endif

	if(exists('self.suffixes'))
		let suffix = self.suffixes.rnd()
		if(exists('suffix.short'))
			let equippable.name.short .= ' ' . suffix.short
			let equippable.name.long .= ' ' . suffix.long
			call s:applymodifier(equippable, suffix)
		endif
	endif

	return equippable
endfunction

function! s:applymodifier(equippable, modifier) abort
	if(a:modifier.stat ==# 'dmg')
		if(!has_key(a:equippable, 'dmg'))
			let a:equippable.dmg = { 'min': 0, 'max': 0 }
		endif
		let a:equippable.dmg.min += a:modifier.min
		let a:equippable.dmg.max += a:modifier.max
	else
		if(!has_key(a:equippable.stats, a:modifier.stat))
			let a:equippable.stats[a:modifier.stat] = 0
		endif
		let a:equippable.stats[a:modifier.stat] += a:modifier.value
	endif
endfunction
