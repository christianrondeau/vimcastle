function! vimcastle#state#explore#enter(state) abort
endfunction

function! vimcastle#state#explore#action(state, key) abort
	if(exists("a:state.enemy"))
		call a:state.enter('fight')
	else
		call s:continue(a:state)
	endif
	return 1
endfunction

function! s:continue(state)
	call s:events[vimcastle#utils#rnd(len(s:events))](a:state)
endfunction

function! s:event_nothing(state)
endfunction

function! s:event_fight(state)
	let a:state.enemy = vimcastle#character#random()
endfunction

let s:events = [
	\  function('s:event_nothing'),
	\  function('s:event_fight')
	\]

