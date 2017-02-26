function! vimcastle#ui#win#draw(screen, state) abort
	call vimcastle#ui#common#drawtitle(a:screen,  'You win!')

	call vimcastle#ui#common#drawlog(a:state.log)

	call vimcastle#ui#actions#draw(a:state.actions())
endfunction

