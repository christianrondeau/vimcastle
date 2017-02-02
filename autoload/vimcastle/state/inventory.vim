function! vimcastle#state#inventory#enter(state) abort
 	call a:state.actions().clear()

	if(exists('a:state.player.items') && len(a:state.player.items))
		call a:state.actions().add('u', 'Use an item', function('s:action_use'))
	endif

	call a:state.actions().add('s', 'Character Sheet', function('s:action_character'))
	call a:state.actions().add('b', 'Back', function('s:action_back'))
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
