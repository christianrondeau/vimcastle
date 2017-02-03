function! vimcastle#ui#use#draw(screen, state) abort
	call vimcastle#ui#common#drawtitle(a:screen,  'Use')

	call append(line('$'), 'Select the item you want to use.')
	call append(line('$'), '')

	call vimcastle#ui#common#drawbindings(a:state.actions())
endfunction

