function! vimcastle#state#inventory#enter(state) abort
 	call a:state.actions().clear()

	if(exists('a:state.player.items') && len(a:state.player.items))
		call a:state.actions().add('use', 'u', 'Use an item')
	endif

	call a:state.actions().add('character', 's', 'Character Sheet')
	call a:state.actions().add('back', 'b', 'Back')
endfunction

function! vimcastle#state#inventory#action(name, state) abort
	execute 'call s:action_' . a:name . '(a:state)'
endfunction

function! s:action_use(state) abort
	call a:state.enter('use')
	return 1
endfunction

function! s:action_character(state) abort
	call a:state.enter('sheet')
	return 1
endfunction

function! s:action_back(state) abort
	call a:state.enter('explore')
	return 1
endfunction
