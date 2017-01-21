function! vimcastle#ui#win#draw(screen, state) abort
	call vimcastle#ui#common#drawtitle(a:screen,  'You win!')
	call append(2, 'You do not gain XP, nor any new item.')
	call append(3, '')
	call vimcastle#ui#common#drawbindings(a:state.nav)
endfunction
