let s:MonsterClass = {}

function! vimcastle#monster#create(basenameshort, basenamelong, basehealth) abort
	let monster = copy(s:MonsterClass)
	let monster.basename = { 'short': a:basenameshort, 'long': a:basenamelong }
	let monster.basehealth = a:basehealth
	return monster
endfunction

function! s:MonsterClass.modifier(probabilities, prefixshort, prefixlong, healthmodifier) dict abort
	if(!exists('self.modifiers'))
		let self.modifiers = vimcastle#repository#create()
	endif
	call self.modifiers.add(a:probabilities, { 'short': a:prefixshort, 'long': a:prefixlong, 'health': a:healthmodifier })
	return self
endfunction

function! s:MonsterClass.weapon(weapon) dict abort
	let self.weapon = a:weapon
	return self
endfunction

function! s:MonsterClass.invoke() dict abort
	let name = { 'short': self.basename.short, 'long': self.basename.long }
	let health = self.basehealth
	if(exists('self.modifiers'))
		let modifier = self.modifiers.rnd()
		let name.short = modifier.short . ' ' . name.short
		let name.long = modifier.long . ' ' . name.long
		let health += modifier.health
	endif
	return vimcastle#character#create(name, health, self.weapon)
endfunction
