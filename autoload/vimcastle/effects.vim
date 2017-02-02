function! vimcastle#effects#heal(state) abort
	let maxhealth = a:state.player.getstat('health', 1)
	if(a:state.player.health < maxhealth)
		let a:state.player.health = maxhealth
	endif
endfunction
