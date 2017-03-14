function! vimcastle#game#create() abort
	let game = {}
	"TODO: Group log functions in a log object?
	"TODO: Potentially useless methods?
	let game.enter = function('s:enter')
	let game.action = function('s:action')
	let game.reset = function('s:reset')
	let game.clearlog = function('s:clearlog')
	let game.addlogrnd = function('s:addlogrnd')
	let game.addlog = function('s:addlog')
	let game.msg = function('s:msg')
	let game.actions = vimcastle#actions#create()
	call game.reset()
	return game
endfunction

function! s:enter(name) dict abort
	execute 'let self.state = vimcastle#states#' . a:name . '#create()'
	call s:validatestate(a:name, self.state)
	"TODO: Let the state decide which screen to use
	let self.screen = a:name
	call self.actions.clear()
	call self.clearlog()
	return self.state.enter(self)
endfunction

function! s:validatestate(name, state) abort
	if(!exists('a:state.enter'))
		throw 'State "' . a:name . '" does not define an enter event'
	endif
endfunction

function! s:action(key) dict abort
	"TODO: Instead of relying on .enter, return a 'new state'
	let name = self.actions.keyToName(a:key)
	if(name == '')
		return 0
	endif
	call self.actions.clear()
	call self.clearlog()
	call self.state.action(name, self)
	return 1
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

	if(exists('self.enemy.name.long'))
		let text = substitute(text, '%<enemy.name>', '<' . self.enemy.name.long . '>', 'ge')
	endif

	if(exists('self.ground_item'))
		let text = substitute(text, '%<ground>', '<' . self.ground_item.label . '>', 'ge')
	endif

	if(exists('self.ground_equippable'))
		let text = substitute(text, '%<ground>', '<' . self.ground_equippable.name.long . '>', 'ge')
	endif

	if(exists('self.enemy.equipment.weapon.name.long'))
		let text = substitute(text, '%<enemy.weapon>', '<' . self.enemy.equipment.weapon.name.long . '>', 'ge')
	endif

	if(exists('self.player.equipment.weapon.name.long'))
		let text = substitute(text, '%<player.weapon>', '<' . self.player.equipment.weapon.name.long . '>', 'ge')
	endif

	return text
endfunction
