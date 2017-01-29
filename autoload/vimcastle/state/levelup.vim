function! vimcastle#state#levelup#enter(state) abort
	let a:state.log = ['Your health was replenished! Select a skill to increase.']

	call a:state.actions().clear()

	call s:addincreaseaction('1', a:state, 'health', 10)
	call s:addincreaseaction('2', a:state, 'str', 1)
	call s:addincreaseaction('3', a:state, 'spd', 1)
	call s:addincreaseaction('4', a:state, 'dex', 1)
endfunction

function! s:addincreaseaction(index, state, stat, by) abort
	let value = a:state.player.getstat(a:stat, 0)
	let msg = 'Increase ' . a:stat . ' ' . value . ' -> ' . (value + a:by)
	call a:state.actions().add(a:index, msg, function('s:action_incr_' . a:stat))
endfunction

function! s:action_incr_str(state) abort
	return s:action_incr(a:state, 'str', 1)
endfunction

function! s:action_incr_spd(state) abort
	return s:action_incr(a:state, 'spd', 1)
endfunction

function! s:action_incr_dex(state) abort
	return s:action_incr(a:state, 'dex', 1)
endfunction

function! s:action_incr_health(state) abort
	return s:action_incr(a:state, 'health', 10)
endfunction

function! s:action_incr(state, stat, by) abort
	let value = a:state.player.getstat(a:stat, 0)
	call a:state.player.setstat(a:stat, value + a:by)
	call s:action_continue(a:state)
endfunction

function! s:action_continue(state) abort
	let maxhealth = a:state.player.getstat('health', 1)
	if(a:state.player.health < maxhealth)
		let a:state.player.health = maxhealth
	endif

	let a:state.player.level += 1

	let [expectedlevel, ignored] = vimcastle#levelling#forxp(a:state.player.xp)
	if(a:state.player.level < expectedlevel)
		call a:state.enter('levelup')
	else
		call a:state.enter('explore')
		call a:state.nextaction(a:state)
		unlet a:state.nextaction
	endif
endfunction
