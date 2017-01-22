function! vimcastle#ui#win#draw(screen, state) abort
	call vimcastle#ui#common#drawtitle(a:screen,  'You win!')
	call append(line('$'), '')
	call vimcastle#ui#common#drawlog(a:state.log)
	call append(line('$'), '')
	call vimcastle#ui#common#drawbindings(a:state.nav)
endfunction
