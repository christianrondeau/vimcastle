function! vimcastle#effects#none(state, value) abort
endfunction

function! vimcastle#effects#heal(state, value) abort
	let maxhealth = a:state.player.getstat('health', 1)

	if(a:state.player.health >= maxhealth)
		call a:state.addlog('Your health is already full!')
		return 0
	endif

	let a:state.player.health += a:value

	if(a:state.player.health >= maxhealth)
		let a:state.player.health = maxhealth
		call a:state.addlog('Your health is fully replenished!')
	else
		call a:state.addlog('You gain <' . a:value . '> health')
	endif

	return 1
endfunction
