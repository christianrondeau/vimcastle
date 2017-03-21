function! vimcastle#screens#gameover#draw(screen, state) abort
	let lines = [
				\'G A M E    O V E R',
				\'',
				\'Events: ' . a:state.stats.events,
				\'Fights: ' . a:state.stats.fights,
				\'Scenes: ' . a:state.stats.scenes,
				\'Score:  ' . a:state.stats.score,
				\'']

	if(a:state.stats.best)
		let lines += [
				\'* NEW BEST SCORE *',
				\''
				\]
	endif

	let lines += [
				\'     <restart>    '
				\]

	call vimcastle#screens#common#drawscreencenter(a:screen, lines)
endfunction
