function! vimcastle#ui#menu#draw(screen, state) abort
	call vimcastle#ui#common#drawtitle(a:screen, 'Vimcastle')
	call append(line('$'), '')

	if(len(a:state.log))
		call vimcastle#ui#common#drawlog(a:state.log)
	endif
	call append(line('$'), '')

	call vimcastle#ui#common#drawbindings(a:state.nav)
endfunction
