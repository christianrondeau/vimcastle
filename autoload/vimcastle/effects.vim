function! vimcastle#effects#none(state, value) abort
endfunction

function! vimcastle#effects#heal(state, value) abort
	let maxhealth = a:state.player.getmaxhealth()

	if(a:state.player.health >= maxhealth)
		call a:state.addlog('Your health is already full!')
		return 0
	endif

	let a:state.player.health += a:value

	if(a:state.player.health >= maxhealth)
		let a:state.player.health = maxhealth
		call a:state.addlog('Your health is fully replenished!')
	else
		call a:state.addlog('You gain <+' . a:value . '> health.')
	endif

	return 1
endfunction

function! vimcastle#effects#gainhealth(state, value) abort
	let a:state.player.basehealth += a:value
	let a:state.player.health  += a:value
	call a:state.addlog('You gain <+' . a:value . '> to your maximum health permanently.')
	return 1
endfunction

function! vimcastle#effects#gainstr(state, value) abort
	call s:incrstat(a:state, 'str', a:value)
	call a:state.addlog('You feel stronger! gain <+' . a:value . '> to your strength permanently.')
	return 1
endfunction

function! s:incrstat(state, stat, value) abort
	call a:state.player.setstat(a:stat, a:state.player.getstat(a:stat, 0) + a:value)
endfunction
