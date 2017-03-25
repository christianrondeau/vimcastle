let s:EquippablegenClass = {}

function! vimcastle#equippablegen#create(slot, name) abort
	let equippablegen = copy(s:EquippablegenClass)
	let equippablegen.slot = a:slot
	let equippablegen.base = {
				\  'name': a:name,
				\  'dmg': { 'min': 0, 'max': 0 },
				\  'stats': {}
				\}
	return equippablegen
endfunction

function! vimcastle#equippablegen#weapon(name, dmgmin, dmgmax) abort
	return vimcastle#equippablegen#create('weapon', a:name)
				\.dmg(a:dmgmin, a:dmgmax)
endfunction

function! vimcastle#equippablegen#armor(name, def) abort
	return vimcastle#equippablegen#create('armor', a:name)
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

function! s:buildmodifier(name, stat, value, max) abort
	let modifier = { 'name': a:name, 'stat': a:stat }
	if(a:stat ==# 'dmg')
		let modifier.min = a:value
		let modifier.max = a:max
	else
		let modifier.value = a:value
	endif
	return modifier
endfunction

function! s:EquippablegenClass.prefix(probabilities, name, stat, value, ...) dict abort
	call self.getprefixes().add(a:probabilities, s:buildmodifier(a:name, a:stat, a:value, a:0 > 0 ? a:1 : 0))
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

function! s:EquippablegenClass.suffix(probabilities, name, stat, value, ...) dict abort
	call self.getsuffixes().add(a:probabilities, s:buildmodifier(a:name, a:stat, a:value, a:0 > 0 ? a:1 : 0))
	return self
endfunction

function! s:EquippablegenClass.invoke() dict abort
	let equippable = deepcopy(self.base)
	let equippable.slot = self.slot

	if(exists('self.prefixes'))
		let prefix = self.prefixes.rnd()
		if(exists('prefix.name'))
			let equippable.name = prefix.name . ' ' . equippable.name
			call s:applymodifier(equippable, prefix)
		endif
	endif

	if(exists('self.suffixes'))
		let suffix = self.suffixes.rnd()
		if(exists('suffix.name'))
			let equippable.name .= ' ' . suffix.name
			call s:applymodifier(equippable, suffix)
		endif
	endif

	let equippable.score = s:computescore(equippable)

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

function! s:computescore(equippable) abort
	let score = 0
	if(exists('a:equippable.dmg'))
		let score += a:equippable.dmg.min + (a:equippable.dmg.max - a:equippable.dmg.min) / 2
	endif
	for stat in keys(a:equippable.stats)
		let score += a:equippable.stats[stat]
	endfor
	return score
endfunction
