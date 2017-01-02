function! vimcastle#ui#lose#draw(screen, state) abort
	call setline(1, 'You lose!')
	call append(1, '')
	call append(2, '<Start over>')
endfunction
