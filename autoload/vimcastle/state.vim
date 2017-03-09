let s:StateClass = {}

function! vimcastle#state#create() abort
	let state = copy(s:StateClass)
	call state.reset()
	return state
endfunction

function! s:StateClass.enter(name) dict abort
	let self.screen = a:name
	execute 'call vimcastle#state#' . a:name . '#enter(self)'
endfunction

function! s:StateClass.actions() dict abort
	if(!has_key(self.screenactions, self.screen))
		let self.screenactions[self.screen] = vimcastle#bindings#create()
	endif
	return self.screenactions[self.screen]
endfunction

function! s:StateClass.action(key) dict abort
	return self.actions().invokeByKey(a:key, self)
endfunction

function! s:StateClass.reset() dict abort
	if(exists('self.enemy'))
		unlet self.enemy
	endif
	if(exists('self.player'))
		unlet self.player
	endif
	let self.screen = 'undefined'
	let self.log = []
	let self.screenactions = {}
	let self.stats = { 'events': 0, 'fights': 0, 'scenes': 0 }
endfunction

function! s:StateClass.clearlog() dict abort
	let self.log = []
endfunction

function! s:StateClass.addlogrnd(texts) dict abort
	if(type(a:texts) != 3)
		throw 'Randomized logs must be arrays: ' . string(texts)
	endif
	call add(self.log, self.msg(vimcastle#utils#oneof(a:texts)))
endfunction

function! s:StateClass.addlog(text) dict abort
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

function! s:StateClass.msg(text) dict abort
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
