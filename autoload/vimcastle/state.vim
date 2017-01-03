let s:state = {}

function! vimcastle#state#init() abort
	let s:state = {
		\  'enter': function('s:enter')
		\}
	call vimcastle#state#enter('intro')
endfunction

function! vimcastle#state#newgame() abort
	let s:state.player = vimcastle#character#create('Player', 'You', 100)
endfunction

function! vimcastle#state#get() abort
	return s:state
endfunction

function! vimcastle#state#action(key) abort
	if(a:key == "q")
		call vimcastle#quit()
		return 0
	endif
	execute 'let result = vimcastle#state#' . s:state.screen . '#action(s:state, a:key)'
	return result
endfunction

function! s:enter(name) abort
	let s:state.screen = a:name
	execute 'call vimcastle#state#' . a:name . '#enter(s:state)'
endfunction
