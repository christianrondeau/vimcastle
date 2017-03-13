function! vimcastle#screens#highscores#draw(screen, game) abort
	call vimcastle#screens#common#drawtitle(a:screen, 'High Scores')

	if(len(a:game.log))
		call vimcastle#screens#common#drawlog(a:game.log)
	endif

	call vimcastle#screens#actions#draw(a:game.actions)
endfunction


