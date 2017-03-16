let s:MonstergenClass = {}

function! vimcastle#monstergen#create(basename) abort
	let monstergen = copy(s:MonstergenClass)
	let monstergen.basename = a:basename
	let monstergen.basehealth = 1
	let monstergen.basexp = 1
	let monstergen.baselevel = 1
	let monstergen.basestats = {}
	return monstergen
endfunction

function! s:MonstergenClass.health(health) dict abort
	let self.basehealth = a:health
	return self
endfunction

function! s:MonstergenClass.xp(xp) dict abort
	let self.basexp = a:xp
	return self
endfunction

function! s:MonstergenClass.level(level) dict abort
	let self.baselevel = a:level
	return self
endfunction

function! s:MonstergenClass.stat(name, value) dict abort
	let self.basestats[a:name] = a:value
	return self
endfunction

function! s:MonstergenClass.description(description) dict abort
	let self.description = a:description
	return self
endfunction

function! s:MonstergenClass.modifier(probabilities, prefix, healthmodifier) dict abort
	if(!exists('self.modifiers'))
		let self.modifiers = vimcastle#repository#create()
	endif
	call self.modifiers.add(a:probabilities, { 'prefix': a:prefix, 'health': a:healthmodifier })
	return self
endfunction

function! s:MonstergenClass.weapon(weapon) dict abort
	if(!exists('self.weapons'))
		let self.weapons = vimcastle#repository#create()
	endif
	call self.weapons.add(1, a:weapon)
	return self
endfunction

function! s:MonstergenClass.invoke() dict abort
	let name = self.basename
	let health = self.basehealth
	let stats = self.basestats
	if(exists('self.modifiers'))
		let modifier = self.modifiers.rnd()
		let name = modifier.prefix . ' ' . name
		let health += modifier.health
	endif
	let monster = vimcastle#character#create(name, health).setstats(stats)
	if(exists('self.weapons'))
		call monster.equip(self.weapons.rnd().invoke())
	endif
	let monster.level = self.baselevel
	let monster.xp = self.basexp
	if(exists('self.description'))
		let monster.description = self.description
	endif
	return monster
endfunction
