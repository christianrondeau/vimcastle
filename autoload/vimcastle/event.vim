let s:EventClass = {}

function! vimcastle#event#create() abort
	let instance = {}
	let instance.enter = function('s:enter')
	let instance.action = function('s:action')
	let instance.action_explore = function('s:action_explore')
	let instance.action_fight = function('s:action_fight')
	let instance.action_enterscene = function('s:action_enterscene')
	let instance.action_inventory = function('s:action_inventory')
	let instance.action_character = function('s:action_character')
	let instance.action_pickup = function('s:action_pickup')
	let instance.action_equip = function('s:action_equip')
	let instance.actions = vimcastle#actions#create()
	let instance.log = []
	return instance
endfunction

function! s:enter(game) abort dict
	let a:game.actions.bindings = self.actions.bindings
	let a:game.log = self.log
endfunction

function! s:action(name, game) abort dict
	execute 'call self.action_' . a:name . '(a:game)'
endfunction

function! s:action_explore(game) abort dict
	let a:game.event = a:game.scene.events.rnd().invoke(a:game)
	call a:game.event.enter(a:game)
endfunction

function! s:action_fight(game) abort dict
	let a:game.stats.fights += 1
	let a:game.enemy = self.enemy
	return a:game.enter('fight')
endfunction

function! s:action_enterscene(game) abort dict
	let a:game.stats.scenes += 1
	let a:game.scene = vimcastle#scene#load(a:game.scene.story, self.nextscene)
	let a:game.event = a:game.scene.enter.invoke(a:game)
	call a:game.event.enter(a:game)
endfunction

function! s:action_inventory(game) abort dict
	call a:game.enter('inventory')
endfunction

function! s:action_character(game) abort dict
	call a:game.enter('sheet')
endfunction

function! s:action_pickup(game) abort dict
	call a:game.player.pickup(self.item)
	call self.action_explore(a:game)
endfunction

function! s:action_equip(game) abort dict
	call a:game.player.equip(self.equippable)
	call self.action_explore(a:game)
endfunction

