let s:EventClass = {}

function! vimcastle#event#create() abort
	let event = copy(s:EventClass)
	return event
endfunction

function! s:EventClass.action(name, state) abort
	execute 'call s:action_' . a:name . '(a:state)'
endfunction

function! s:action_explore(state) abort
	call s:cleanup(a:state)
	let a:state.event = a:state.scene.events.rnd().invoke(a:state)
endfunction

function! s:action_fight(state) abort
	let a:state.stats.fights += 1
	let a:state.nextaction = function('s:action_explore')
	call s:cleanup(a:state)
	call a:state.enter('fight')
endfunction

function! s:action_enterscene(state) abort
	let a:state.stats.scenes += 1
	let a:state.scene = vimcastle#scene#load(a:state.scene.story, a:state.nextscene)
	call s:cleanup(a:state)
	let a:state.event = a:state.scene.enter.invoke(a:state)
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
	call a:state.player.equip(a:state.ground_equippable)
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

	if(exists('a:state.nextscene'))
		unlet a:state.nextscene
	endif
endfunction

function! s:showequippablediff(state) abort
	if(has_key(a:state.player.equipment, a:state.ground_equippable.slot))
		let current = a:state.player.equipment[a:state.ground_equippable.slot]
	else
		let current = vimcastle#equippablegen#create(a:state.ground_equippable.slot, 0, 0)
	endif

	if(a:state.ground_equippable.slot ==# 'weapon')
		call s:showequippabledmg(a:state, current, a:state.ground_equippable)
	endif
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
		let diff = '='
	endif
	return a:ground . ' (' . diff . ')'
endfunction
