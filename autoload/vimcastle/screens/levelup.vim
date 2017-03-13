function! vimcastle#screens#levelup#draw(screen, game) abort
	call vimcastle#screens#common#drawtitle(a:screen, 'Level up!')

	call vimcastle#screens#common#drawcenter(a:screen, 'You gained a level!')
	call append(line('$'), '')

	call vimcastle#screens#common#drawcenter(a:screen, 'Level ' . a:game.player.level . ' -> ' . (a:game.player.level + 1))
	call append(line('$'), '')
	
	call vimcastle#screens#common#drawlog(a:game.log)

	call vimcastle#screens#actions#draw(a:game.actions)
endfunction


