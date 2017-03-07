function! vimcastle#ui#highscores#draw(screen, state) abort
	call vimcastle#ui#common#drawtitle(a:screen, 'High Scores')

	if(len(a:state.log))
		call vimcastle#ui#common#drawlog(a:state.log)
	endif

	call vimcastle#ui#actions#draw(a:state.actions())
endfunction

