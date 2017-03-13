function! vimcastle#states#win#enter(state) abort
	call a:state.actions().clear()
	call a:state.clearlog()
	
	let [ignored, nextlevelxp] = vimcastle#levelling#forxp(a:state.player.xp)

	let xp = a:state.enemy.xp
	let a:state.player.xp += xp
	unlet a:state.enemy

	let [expectedlevel, ignored] = vimcastle#levelling#forxp(a:state.player.xp)

	call a:state.addlog('You gained:')
	call a:state.addlog('  * ' . xp . ' xp! (' . a:state.player.xp . '/' . nextlevelxp . ' xp)')

	if(a:state.player.level < expectedlevel)
		call a:state.actions().add('levelup', 'u', 'Level up!')
	else
		call a:state.actions().add('continue', 'c', 'Continue')
	endif
endfunction

function! vimcastle#states#win#action(name, state) abort
	execute 'call s:action_' . a:name . '(a:state)'
endfunction

function! s:action_continue(state) abort
	call a:state.enter('explore')
	call a:state.nextaction(a:state)
	unlet a:state.nextaction
	return 1
endfunction

function! s:action_levelup(state) abort
	call a:state.enter('levelup')
	return 1
endfunction
