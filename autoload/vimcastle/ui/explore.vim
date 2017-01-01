function! vimcastle#ui#explore#draw(screen, state) abort
	call setline(1, 'You wander aimlessly when you encounter an enemy!')
	call append(1, '')
	call append(2, '<Fight!>')
endfunction
