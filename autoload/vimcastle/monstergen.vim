let s:MonstergenClass = {}

function! vimcastle#monstergen#create(basenameshort, basenamelong) abort
	let monstergen = copy(s:MonstergenClass)
	let monstergen.basename = { 'short': a:basenameshort, 'long': a:basenamelong }
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

function! s:MonstergenClass.modifier(probabilities, prefixshort, prefixlong, healthmodifier) dict abort
	if(!exists('self.modifiers'))
		let self.modifiers = vimcastle#repository#create()
	endif
	call self.modifiers.add(a:probabilities, { 'short': a:prefixshort, 'long': a:prefixlong, 'health': a:healthmodifier })
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
	let name = { 'short': self.basename.short, 'long': self.basename.long }
	let health = self.basehealth
	let stats = self.basestats
	if(exists('self.modifiers'))
		let modifier = self.modifiers.rnd()
		let name.short = modifier.short . ' ' . name.short
		let name.long = modifier.long . ' ' . name.long
		let health += modifier.health
	endif
	let monster = vimcastle#character#create(name, health).setstats(stats)
	if(exists('self.weapons'))
		call monster.equipweapon(self.weapons.rnd().invoke())
	endif
	let monster.level = self.baselevel
	let monster.xp = self.basexp
	return monster
endfunction
