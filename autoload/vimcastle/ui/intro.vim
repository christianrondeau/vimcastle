function! vimcastle#ui#intro#draw(screen, state) abort
	call setline(1, 'Welcome to Vimcastle')
	call append(1, 'Press 1 to start')
endfunction
