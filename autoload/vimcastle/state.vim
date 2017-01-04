let s:state = {}

function! vimcastle#state#init() abort
	let s:state = {
		\ 'enter': function('s:enter'),
		\ 'newgame': function('s:newgame'),
		\ 'action': function('s:action'),
		\ 'clear': function('s:clear'),
		\ 'reset': function('vimcastle#state#init')
		\}
	call s:state.enter('intro')
	return s:state
endfunction

function! vimcastle#state#get() abort
	return s:state
endfunction

function! s:action(key) abort
	if(a:key == "q")
		call vimcastle#quit()
		return 0
	elseif(exists('s:state.screen'))
		execute 'let result = vimcastle#state#' . s:state.screen . '#action(s:state, a:key)'
		return result
	else
		return 0
	endif
endfunction

function! s:newgame() abort
	let s:state.player = vimcastle#character#create('Player', 'You', 80)
endfunction

function! s:enter(name) abort
	let s:state.screen = a:name
	execute 'call vimcastle#state#' . a:name . '#enter(s:state)'
endfunction

function! s:clear() abort
	unlet s:state
endfunction
