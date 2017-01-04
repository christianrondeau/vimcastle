function! vimcastle#ui#lose#draw(screen, state) abort
	call vimcastle#ui#common#drawscreencenter(a:screen, [
		\'G A M E    O V E R',
		\'                  '
		\'     <restart>    '
		\])
endfunction
