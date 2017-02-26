function! vimcastle#ui#menu#draw(screen, state) abort
	call vimcastle#ui#common#drawtitle(a:screen, 'Vimcastle')

	if(len(a:state.log))
		call vimcastle#ui#common#drawlog(a:state.log)
	endif

	call vimcastle#ui#actions#draw(a:state.actions())
endfunction

