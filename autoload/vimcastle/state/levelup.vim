function! vimcastle#state#levelup#enter(state) abort
	call s:addincreaseaction(1, a:state, 'str')
	call s:addincreaseaction(1, a:state, 'spd')
	call s:addincreaseaction(1, a:state, 'dex')
endfunction

function! s:addincreaseaction(index, state, stat) abort
	let value = a:state.player.getstat(a:stat, 0)
	call a:state.nav.add(a:index, 'Increase ' . a:stat . ' ' . value . ' -> ' (value + 1), function('s:action_incr_' . a:stat))
endfunction

function! s:action_incr_str(state) abort
	return s:action_incr(a:state, 'str')
endfunction

function! s:action_incr_spd(state) abort
	return s:action_incr(a:state, 'spd')
endfunction

function! s:action_incr_dex(state) abort
	return s:action_incr(a:state, 'dex')
endfunction

function! s:action_incr(state, stat) abort
	let value = a:state.player.getstat(a:stat, 0)
	call a:state.player.setstat(a:stat, value + 1)
	call a:state.enter('explore')
	call a:state.nextaction(a:state)
	unlet a:state.nextaction
	return 1
endfunction
