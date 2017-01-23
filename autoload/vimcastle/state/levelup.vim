function! vimcastle#state#levelup#enter(state) abort
	let a:state.log = ['Your health was replenished! Select a skill to increase.']

	call a:state.actions().clear()

	let msg = 'Increase health ' . a:state.player.health.max . ' -> ' . (a:state.player.health.max + 10)
	call a:state.actions().add('1', msg, function('s:action_incr_health'))

	call s:addincreaseaction('2', a:state, 'str')
	call s:addincreaseaction('3', a:state, 'spd')
	call s:addincreaseaction('4', a:state, 'dex')
endfunction

function! s:addincreaseaction(index, state, stat) abort
	let value = a:state.player.getstat(a:stat, 0)
	let msg = 'Increase ' . a:stat . ' ' . value . ' -> ' . (value + 1)
	call a:state.actions().add(a:index, msg, function('s:action_incr_' . a:stat))
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
	call s:action_continue(a:state)
endfunction

function! s:action_incr_health(state) abort
	let a:state.player.health.max += 10
	call s:action_continue(a:state)
endfunction

function! s:action_continue(state) abort
	let a:state.player.health.current = a:state.player.health.max
	let a:state.player.level += 1
	call a:state.enter('explore')
	call a:state.nextaction(a:state)
	unlet a:state.nextaction
endfunction
