let s:StateClass = {}

function! vimcastle#state#create() abort
	let state = copy(s:StateClass)
	let state.nav = vimcastle#bindings#create()
	let state.actions = vimcastle#bindings#create()
	call state.reset()
	return state
endfunction

function! s:StateClass.enter(name) dict abort
	call self.nav.clear()
	let self.screen = a:name
	execute 'call vimcastle#state#' . a:name . '#enter(self)'
endfunction

function! s:StateClass.action(key) dict abort
	if(self.actions.invokeByKey(a:key, self))
		return 1
	elseif(self.nav.invokeByKey(a:key, self))
		return 1
	else
		return self.nav.invokeDefault(self)
	endif
endfunction

function! s:StateClass.reset() dict abort
	if(exists('self.enemy'))
		unlet self.enemy
	endif
	if(exists('self.player'))
		unlet self.player
	endif
	let self.log = []
	call self.nav.clear()
	call self.actions.clear()
	let self.stats = { 'events': 0, 'fights': 0, 'scenes': 0 }
endfunction

function! s:StateClass.addlog(text) dict abort
	if(type(a:text) == 3)
		call add(self.log, self.msg(vimcastle#utils#oneof(a:text)))
	else
		call add(self.log, self.msg(a:text))
	endif
endfunction

function! s:StateClass.msg(text) dict abort
	let text = a:text
	if(exists('self.enemy.name.long'))
		let text = substitute(text, '%<enemy.name>', '<' . self.enemy.name.long . '>', 'ge')
	endif
	if(exists('self.enemy.equipment.weapon.name.long'))
		let text = substitute(text, '%<enemy.weapon>', '<' . self.enemy.equipment.weapon.name.long . '>', 'ge')
	endif
	if(exists('self.player.equipment.weapon.name.long'))
		let text = substitute(text, '%<player.weapon>', '<' . self.player.equipment.weapon.name.long . '>', 'ge')
	endif
	return text
endfunction
