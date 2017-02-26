function! vimcastle#ui#levelup#draw(screen, state) abort
	call vimcastle#ui#common#drawtitle(a:screen, 'Level up!')

	call vimcastle#ui#common#drawcenter(a:screen, 'You gained a level!')
	call append(line('$'), '')

	call vimcastle#ui#common#drawcenter(a:screen, 'Level ' . a:state.player.level . ' -> ' . (a:state.player.level + 1))
	call append(line('$'), '')
	
	call vimcastle#ui#common#drawlog(a:state.log)

	call vimcastle#ui#actions#draw(a:state.actions())
endfunction

