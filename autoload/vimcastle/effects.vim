function! vimcastle#effects#heal(state, value) abort
	let maxhealth = a:state.player.getstat('health', 1)
	if(a:state.player.health < maxhealth)
		let a:state.player.health += a:value
		if(a:state.player.health > maxhealth)
			let a:state.player.health = maxhealth
		endif
	endif
endfunction
