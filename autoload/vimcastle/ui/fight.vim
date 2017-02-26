function! vimcastle#ui#fight#draw(screen, state) abort
	call vimcastle#ui#common#drawtitle(a:screen, 'Fight!')

	call s:drawsides(a:screen, a:state.player.name.short,a:state.enemy.name.short)
	call s:drawbars(a:screen, a:state.player.health, a:state.player.getstat('health', 1), a:state.enemy.health, a:state.enemy.getstat('health', 1), '-')
	call append(line('$'), '')

	if(len(a:state.log))
		call vimcastle#ui#common#drawlog(a:state.log)
	endif

	call vimcastle#ui#actions#draw(a:state.actions())
endfunction

function! s:drawsides(screen, left, right) abort
	let pad = a:screen.width - strlen(a:left) - strlen(a:right) - 2
	call append(line('$'), ' ' . a:left . repeat(' ', pad) . a:right)
endfunction

function! s:drawbars(screen, lval, lmax, rval, rmax, char) abort
	let barwidth = a:screen.width / 2 - 8
	call s:drawsides(
		\ a:screen,
		\ vimcastle#ui#common#getbar(barwidth, a:lval, a:lmax, a:char) .
		\ ' ' . a:lval,
		\ a:rval . ' ' . 
		\ vimcastle#ui#common#getbar(barwidth, a:rval, a:rmax, a:char)
		\ )
endfunction
