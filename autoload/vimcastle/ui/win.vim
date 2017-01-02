function! vimcastle#ui#win#draw(screen, state) abort
	call setline(1, 'You win!')
	call append(1, '')
	call append(2, '<Continue exploring>')
endfunction
