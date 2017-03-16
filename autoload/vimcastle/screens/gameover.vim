function! vimcastle#screens#gameover#draw(screen, state) abort
	call vimcastle#screens#common#drawscreencenter(a:screen, [
		\'G A M E    O V E R',
		\'',
		\'Events: ' . a:state.stats.events,
		\'Fights: ' . a:state.stats.fights,
		\'Scenes: ' . a:state.stats.scenes,
		\'Score:  ' . a:state.stats.score,
		\'',
		\'     <restart>    '
		\])
endfunction