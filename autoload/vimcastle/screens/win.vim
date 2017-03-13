function! vimcastle#screens#win#draw(screen, game) abort
	call vimcastle#screens#common#drawtitle(a:screen,  'You win!')

	call vimcastle#screens#common#drawlog(a:game.log)

	call vimcastle#screens#actions#draw(a:game.actions)
endfunction


