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

function! s:reset() abort
	if(exists('s:state.enemy'))
		unlet s:state.enemy
	endif
	if(exists('s:state.player'))
		unlet s:state.player
	endif
	call s:state.enter('intro')
endfunction

function! s:action(key) abort
	if(a:key == "q")
		call vimcastle#quit()
		return 0
	elseif(exists('s:state.actions'))
		if(has_key(s:state.actions, a:key))
			call s:state.actions[a:key].fn(s:state)
			return 1
		elseif(has_key(s:state.actions, 'any'))
			call s:state.actions['any'].fn(s:state)
			return 1
		else
			return 0
		endif
	endif
endfunction

function! s:newgame() abort
	let s:state.player = vimcastle#character#create('Player', 'You', 60)
endfunction

function! s:enter(name) abort
	let s:state.actions = []
	let s:state.log = []
	let s:state.screen = a:name
	execute 'call vimcastle#state#' . a:name . '#enter(s:state)'
endfunction

function! s:clear() abort
	unlet s:state
endfunction
