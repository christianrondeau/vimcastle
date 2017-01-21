function! vimcastle#ui#levelup#draw(screen, state) abort
	call vimcastle#ui#common#drawtitle(a:screen, 'Level up!')
	call append(line('$'), '')
	call vimcastle#ui#common#drawcenter(a:screen, 'You gained a level!')
	call append(line('$'), '')
	call vimcastle#ui#common#drawcenter(a:screen, 'Level 6 -> 7')
	call append(line('$'), '')
	call vimcastle#ui#common#drawbindings(a:state.actions)
endfunction
