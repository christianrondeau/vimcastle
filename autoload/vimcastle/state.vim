let s:StateClass = {}

function! vimcastle#state#create() abort
	let instance = copy(s:StateClass)
	let instance.actions = vimcastle#actions#create()
	let instance.story = vimcastle#story#create()
	call instance.reset()
	return instance
endfunction

function! s:StateClass.enter(name) dict abort
	call self.actions.clear()
	let self.log = []
	let self.screen = a:name
	execute 'call vimcastle#state#' . a:name . '#enter(self)'
endfunction

function! s:StateClass.action(key) dict abort
	if(a:key == "q")
		call vimcastle#quit()
		return 0
	elseif(self.actions.invokeByKey(a:key, self))
		return 1
	else
		return self.actions.invokeDefault(self)
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
	call self.actions.clear()
endfunction
