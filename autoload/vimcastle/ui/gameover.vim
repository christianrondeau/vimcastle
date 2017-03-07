function! vimcastle#ui#gameover#draw(screen, state) abort
	call vimcastle#ui#common#drawscreencenter(a:screen, [
		\'G A M E    O V E R',
		\'',
		\'Events: ' . a:state.stats.events,
		\'Scenes: ' . a:state.stats.scenes,
		\'Fights: ' . a:state.stats.fights,
		\'Score:  ' . a:state.stats.score,
		\'',
		\'     <restart>    '
		\])
endfunction
