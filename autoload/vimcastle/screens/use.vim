function! vimcastle#screens#use#draw(screen, game) abort
	call vimcastle#screens#common#drawtitle(a:screen,  'Use')

	if(len(a:game.log))
		call vimcastle#screens#common#drawlog(a:game.log)
	endif

	call append(line('$'), 'Select the item you want to use.')
	call append(line('$'), '')

	call vimcastle#screens#actions#draw(a:game.game.actions)
endfunction


