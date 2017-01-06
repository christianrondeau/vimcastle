let s:state = {}

function! vimcastle#state#init() abort
	let s:state = {
		\ 'enter': function('s:enter'),
		\ 'newgame': function('s:newgame'),
		\ 'action': function('s:action'),
		\ 'clear': function('s:clear'),
		\ 'reset': function('s:reset')
		\}
	call s:reset()
	return s:state
endfunction

function! vimcastle#state#get() abort
	return s:state
endfunction

function! s:clean() abort
	if(exists('s:state.enemy'))
		unlet s:state.enemy
	endif
	if(exists('s:state.player'))
		unlet s:state.player
	endif
	let s:state.actions = vimcastle#actions#create()
endfunction

function! s:reset() abort
	call s:clean()
	call s:state.enter('intro')
endfunction

function! s:action(key) abort
	if(a:key == "q")
		call vimcastle#quit()
		return 0
	elseif(s:state.actions.invokeByKey(a:key, s:state))
		return 1
	else
		return s:state.actions.invokeDefault(s:state)
	endif
endfunction

function! s:newgame() abort
	call s:clean()
	let s:state.player = vimcastle#character#create('Player', 'You', 60)
	call s:state.enter('explore')
endfunction

function! s:enter(name) abort
	call s:state.actions.clear()
	let s:state.log = []
	let s:state.screen = a:name
	execute 'call vimcastle#state#' . a:name . '#enter(s:state)'
endfunction

function! s:clear() abort
	unlet s:state
endfunction
