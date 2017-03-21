function! vimcastle#game#create() abort
	let game = {}
	let game.autosave = !exists('g:vader_file')
	let game.enter = function('s:enter')
	let game.action = function('s:action')
	let game.callstateaction = function('s:callstateaction')
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
	if(name ==# '')
		return 0
	endif
	call self.actions.clear()
	call self.clearlog()

	if(self.callstateaction(name))
		if(self.autosave && self.state.cansave && exists('self.scene') && exists('self.event.actions'))
			call vimcastle#io#save(self.save())
		endif
		return 1
	endif

	throw 'No action_' . name . ' nor action on state ' . self.screen . ' but bound to ' . a:key
endfunction

function! s:callstateaction(name) dict abort
	if(exists('self.state.action_' . a:name))
		execute 'call self.state.action_' . a:name . '(self)'
		return 1
	endif

	if(exists('self.state.action'))
		execute 'call self.state.action(a:name, self)'
		return 1
	endif
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
		throw 'Randomized logs must be arrays: ' . string(a:texts)
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

" Saving {{{

function! s:save() abort dict
	let data = {}
	let data.screen = self.screen
	let data.scene = self.scene.save()

	if(exists('self.player'))
		let data.player = self.player.save()
	endif

	if(exists('self.event'))
		let data.event = self.event.save()
	endif

	if(exists('self.enemy'))
		let data.enemy = self.enemy.save()
	endif

	return data
endfunction

function! s:load(data) abort dict
	let self.scene = vimcastle#scene#load(a:data.scene.story, a:data.scene.name)

	if(exists('a:data.player'))
		let player = vimcastle#character#create('', 0)
		call player.load(a:data.player)
		let self.player = player
	endif

	if(exists('a:data.event'))
		let event = vimcastle#event#create()
		call event.load(a:data.event)
		let self.event = event
	endif

	if(exists('a:data.enemy'))
		let enemy = vimcastle#character#create('', 0)
		call enemy.load(a:data.enemy)
		let self.enemy = enemy
	endif

	call self.enter(a:data.screen)
endfunction

" }}}
