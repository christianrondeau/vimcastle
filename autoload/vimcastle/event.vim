let s:EventClass = {}

function! vimcastle#event#create(name) abort
	let event = copy(s:EventClass)
	let event.name = a:name
	let event.texts = []
	return event
endfunction

function! s:EventClass.text(texts) dict abort
	call add(self.texts, type(a:texts) == 1 ? [a:texts] : a:texts)
	return self
endfunction

function! s:EventClass.explore(text) dict abort
	let self.action_explore_text = a:text
	return self
endfunction

function! s:EventClass.fight(text, monsters) dict abort
	let self.monsters = a:monsters
	let self.action_fight_text = a:text
	return self
endfunction

function! s:EventClass.finditem(items) dict abort
	let self.items = a:items
	return self
endfunction

function! s:EventClass.findequippable(equippables) dict abort
	let self.equippables = a:equippables
	return self
endfunction

function! s:EventClass.enterscene(text, scene) dict abort
	let self.nextscene = a:scene
	let self.action_enterscene_text = a:text
	return self
endfunction

function! s:EventClass.effect(fn, value) dict abort
	call vimcastle#utils#validate(a:fn, 2)
	let self.effect_fn = a:fn
	let self.effect_value = a:value
	return self
endfunction

function! s:EventClass.invoke(state) dict abort
	let a:state.stats.events += 1

	if(exists('self.monsters'))
		let a:state.enemy = self.monsters.rnd().invoke()
	endif

	if(exists('self.items'))
		let a:state.ground_item = self.items.rnd()
	endif

	if(exists('self.equippables'))
		let a:state.ground_equippable = self.equippables.rnd().invoke()
	endif

	let a:state.log = []
	for lineoptions in self.texts
		let line = vimcastle#utils#oneof(lineoptions)
		call add(a:state.log, a:state.msg(line))
	endfor

	if(exists('a:state.ground_equippable'))
		call s:showequippablediff(a:state)
	endif

	if(exists('self.effect_fn'))
		try
			call self.effect_fn(a:state, self.effect_value)
		catch
			throw 'There was an error in effect of ' . a:state.scene.story . '/' . a:state.scene.name . '/' . self.name . ': ' . v:exception
		endtry
	endif

	call a:state.actions().clear()

	if(exists('self.action_fight_text'))
		call a:state.actions().add('f', self.action_fight_text, function('s:action_fight'))
	endif

	if(exists('self.action_enterscene_text'))
		" NOTE: Cannot use arglist in 7.4
		" call a:state.actions().add('e', self.action_enterscene_text, function('s:action_enterscene', [self.nextscene]))
		let a:state.nextscene = self.nextscene
		call a:state.actions().add('e', self.action_enterscene_text, function('s:action_enterscene'))
	endif

	if(exists('a:state.ground_item'))
		call a:state.actions().add('p', 'Pick up', function('s:action_pickup_item'))
	endif

	if(exists('a:state.ground_equippable'))
		call a:state.actions().add('e', 'Equip', function('s:action_equip_equippable'))
	endif

	if(exists('self.action_explore_text'))
		call a:state.actions().add('c', self.action_explore_text, function('s:action_explore'))
	endif

	if(!exists('self.action_fight_text'))
		call a:state.actions().add('i', 'Inventory', function('s:action_inventory'))
		call a:state.actions().add('s', 'Character Sheet', function('s:action_character'))
	endif
endfunction

function! s:action_explore(state) abort
	call s:cleanup(a:state)
	call a:state.scene.events.rnd().invoke(a:state)
endfunction

function! s:action_fight(state) abort
	let a:state.stats.fights += 1
	let a:state.nextaction = function('s:action_explore')
	call s:cleanup(a:state)
	call a:state.enter('fight')
endfunction

function! s:action_enterscene(state) abort
	call s:cleanup(a:state)
	let a:state.stats.scenes += 1
	let a:state.scene = vimcastle#scene#load(a:state.scene.story, a:state.nextscene)
	call a:state.scene.enter.invoke(a:state)
endfunction

function! s:action_inventory(state) abort
	call a:state.enter('inventory')
endfunction

function! s:action_character(state) abort
	call a:state.enter('sheet')
endfunction

function! s:action_pickup_item(state) abort
	call a:state.player.pickup(a:state.ground_item)
	call s:cleanup(a:state)
	call a:state.scene.events.rnd().invoke(a:state)
endfunction

function! s:action_equip_equippable(state) abort
	call a:state.player.equip('weapon', a:state.ground_equippable)
	call s:cleanup(a:state)
	call a:state.scene.events.rnd().invoke(a:state)
endfunction

function! s:cleanup(state) abort
	if(exists('a:state.ground_item'))
		unlet a:state.ground_item
	endif

	if(exists('a:state.ground_equippable'))
		unlet a:state.ground_equippable
	endif
endfunction

function! s:showequippablediff(state) abort
	if(exists('a:state.player.equipment.weapon'))
		let current = a:state.player.equipment.weapon
	else
		let current = vimcastle#equippablegen#weapon('', '', 0, 0)
	endif

	call s:showequippabledmg(a:state, current, a:state.ground_equippable)
	call s:showequippablestats(a:state, current, a:state.ground_equippable)
endfunction

function! s:showequippabledmg(state, current, ground) abort
	let msg = '  * dmg: ' . s:getdiff(a:current['dmg'].min, a:ground['dmg'].min) . ' - ' . s:getdiff(a:current['dmg'].max, a:ground['dmg'].max)
	call add(a:state.log, msg)
endfunction

function! s:showequippablestats(state, current, ground) abort
	let allstats = copy(a:ground.stats)
	for curkey in keys(a:current.stats)
		if(!has_key(allstats, curkey))
			let allstats[curkey] = a:current.stats[curkey]
		endif
	endfor
	for name in sort(keys(allstats))
		let currentval = has_key(a:current.stats, name) ? a:current.stats[name] : 0
		let groundval = has_key(a:ground.stats, name) ? a:ground.stats[name] : 0
		let msg = '  * ' . name . ': ' . s:getdiff(currentval, groundval)
	call add(a:state.log, msg)
	endfor
endfunction

function! s:getdiff(current, ground) abort
	if(a:ground > a:current)
		let diff = '+' . (a:ground - a:current)
	elseif(a:ground < a:current)
		let diff = '-' . (a:current - a:ground)
	else
		let diff = '=' . a:current
	endif
	return a:ground . ' (' . diff . ')'
endfunction
