function! vimcastle#game#create() abort
	let game = {}
	let game.enter = function('s:enter')
	let game.action = function('s:action')
	let game.reset = function('s:reset')
	let game.clearlog = function('s:clearlog')
	let game.addlogrnd = function('s:addlogrnd')
	let game.addlog = function('s:addlog')
	let game.msg = function('s:msg')
	let game.msgevent = function('s:msgevent')
	let game.save = function('s:save')
	let game.load = function('s:load')
	let game.actions = vimcastle#actions#create()
	call game.reset()
	return game
endfunction

function! s:enter(name) dict abort
	execute 'let self.state = vimcastle#states#' . a:name . '#create()'
	if(!exists('self.state.enter'))
		throw 'State "' . a:name . '" does not define an enter event'
	endif
	let self.screen = a:name
	call self.actions.clear()
	call self.clearlog()
	return self.state.enter(self)
endfunction

function! s:action(key) dict abort
	let name = self.actions.keyToName(a:key)
	if(name == '')
		return 0
	endif
	call self.actions.clear()
	call self.clearlog()

	if(exists('self.state.action_' . name))
		execute 'call self.state.action_' . name . '(self)'
		return 1
	endif

	if(exists('self.state.action'))
		execute 'call self.state.action(name, self)'
		return 1
	endif

	throw 'No action_' . name . ' nor action on state ' . self.screen . ' but bound to ' . a:key
endfunction

function! s:reset() dict abort
	if(exists('self.enemy'))
		unlet self.enemy
	endif
	if(exists('self.player'))
		unlet self.player
	endif
	let self.screen = 'undefined'
	call self.clearlog()
	call self.actions.clear()
	let self.stats = { 'events': 0, 'fights': 0, 'scenes': 0 }
endfunction

function! s:clearlog() dict abort
	let self.log = []
endfunction

function! s:addlogrnd(texts) dict abort
	if(type(a:texts) != 3)
		throw 'Randomized logs must be arrays: ' . string(texts)
	endif
	call add(self.log, self.msg(vimcastle#utils#oneof(a:texts)))
endfunction

function! s:addlog(text) dict abort
	if(type(a:text) == 3)
		let list = []
		for line in a:text
			call add(list, self.msg(line))
		endfor
		call add(self.log, list)
	elseif(type(a:text) == 1)
		call add(self.log, self.msg(a:text))
	else
		throw 'Invalid log type: ' . string(a:text)
	endif
endfunction

function! s:msg(text) dict abort
	let text = a:text

	if(exists('self.enemy.name'))
		let text = substitute(text, '%<enemy.name>', '<' . self.enemy.name . '>', 'ge')
	endif

	if(exists('self.enemy.equipment.weapon.name.long'))
		let text = substitute(text, '%<enemy.weapon>', '<' . self.enemy.equipment.weapon.name.long . '>', 'ge')
	endif

	if(exists('self.player.equipment.weapon.name.long'))
		let text = substitute(text, '%<player.weapon>', '<' . self.player.equipment.weapon.name.long . '>', 'ge')
	endif

	return text
endfunction

function! s:msgevent(text, event) dict abort
	let text = self.msg(a:text)

	if(exists('a:event.enemy.name'))
		let text = substitute(text, '%<enemy.name>', '<' . a:event.enemy.name . '>', 'ge')
	endif

	if(exists('a:event.item'))
		let text = substitute(text, '%<ground>', '<' . a:event.item.label . '>', 'ge')
	endif

	if(exists('a:event.equippable'))
		let text = substitute(text, '%<ground>', '<' . a:event.equippable.name.long . '>', 'ge')
	endif

	return text
endfunction

function! s:save() abort dict
	let data = {}
	let data.player = self.player.save()
	return data
endfunction

function! s:load(data) abort dict
  let player = vimcastle#character#create('', 0)
	call player.load(a:data.player)
	let self.player = player
endfunction
