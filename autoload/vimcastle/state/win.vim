function! vimcastle#state#win#enter(state) abort
	let a:state.log = []

	let xp = a:state.enemy.xp
	let a:state.player.xp += xp

	call a:state.addlog('You gained:')
  call a:state.addlog('  * ' . xp . ' xp! (total: ' . a:state.player.xp . ' xp)')

	call a:state.nav.add('c', 'Continue', function('s:nav_continue'))
endfunction

function! s:nav_continue(state) abort
	unlet a:state.enemy
	call a:state.enter('explore')
	call a:state.nextaction(a:state)
	unlet a:state.nextaction
	return 1
endfunction
