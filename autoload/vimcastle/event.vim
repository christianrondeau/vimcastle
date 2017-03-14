let s:EventClass = {}

function! vimcastle#event#create() abort
	let instance = {}
	let instance.enter = function('s:enter')
	let instance.action = function('s:action')
	let instance.actions = vimcastle#bindings#create()
	let instance.log = []
	return instance
endfunction

function! s:enter(game) abort dict
	let a:game.actions.display = self.actions.display
	let a:game.log = self.log
endfunction

function! s:action(name, game) abort dict
	execute 'return s:action_' . a:name . '(a:game)'
endfunction

function! s:action_explore(game) abort
	call s:cleanup(a:game)
	let a:game.event = a:game.scene.events.rnd().invoke(a:game)
	call a:game.event.enter(a:game)
endfunction

function! s:action_fight(game) abort
	let a:game.stats.fights += 1
	let a:game.nextaction = function('s:action_explore')
	call s:cleanup(a:game)
	return a:game.enter('fight')
endfunction

function! s:action_enterscene(game) abort
	let a:game.stats.scenes += 1
	let a:game.scene = vimcastle#scene#load(a:game.scene.story, a:game.nextscene)
	call s:cleanup(a:game)
	"TODO: Rename entryevent?
	let a:game.event = a:game.scene.enter.invoke(a:game)
	call a:game.event.enter(a:game)
endfunction

function! s:action_inventory(game) abort
	call a:game.enter('inventory')
endfunction

function! s:action_character(game) abort
	call a:game.enter('sheet')
endfunction

function! s:action_pickup_item(game) abort
	call a:game.player.pickup(a:game.ground_item)
	call s:cleanup(a:game)
	call s:action_explore(a:game)
endfunction

function! s:action_equip_equippable(game) abort
	call a:game.player.equip(a:game.ground_equippable)
	call s:cleanup(a:game)
	call s:action_explore(a:game)
endfunction

function! s:cleanup(game) abort
	if(exists('a:game.ground_item'))
		unlet a:game.ground_item
	endif

	if(exists('a:game.ground_equippable'))
		unlet a:game.ground_equippable
	endif

	if(exists('a:game.nextscene'))
		unlet a:game.nextscene
	endif
endfunction

function! s:showequippablediff(game) abort
	if(has_key(a:game.player.equipment, a:game.ground_equippable.slot))
		let current = a:game.player.equipment[a:game.ground_equippable.slot]
	else
		let current = vimcastle#equippablegen#create(a:game.ground_equippable.slot, 0, 0)
	endif

	if(a:game.ground_equippable.slot ==# 'weapon')
		call s:showequippabledmg(a:game, current, a:game.ground_equippable)
	endif
	call s:showequippablestats(a:game, current, a:game.ground_equippable)
endfunction

function! s:showequippabledmg(game, current, ground) abort
	let msg = '  * dmg: ' . s:getdiff(a:current['dmg'].min, a:ground['dmg'].min) . ' - ' . s:getdiff(a:current['dmg'].max, a:ground['dmg'].max)
	call add(a:game.log, msg)
endfunction

function! s:showequippablestats(game, current, ground) abort
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
	call add(a:game.log, msg)
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
