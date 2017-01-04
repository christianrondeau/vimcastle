function! vimcastle#ui#win#draw(screen, state) abort
	call setline(1, 'You win!')
	call append(1, '')
	call append(2, 'You do not gain XP, nor any new item.')
	call append(3, '')
	call vimcastle#ui#common#drawactions(a:state.actions)
endfunction
