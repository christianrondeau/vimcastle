function! vimcastle#screens#fight#draw(screen, game) abort
	call vimcastle#screens#common#drawtitle(a:screen, 'Fight!')

	call s:drawsides(a:screen, a:game.player.name.short,a:game.enemy.name.short)
	call s:drawbars(a:screen, a:game.player.health, a:game.player.getmaxhealth(), a:game.enemy.health, a:game.enemy.getmaxhealth(), '-')
	call append(line('$'), '')

	if(len(a:game.log))
		call vimcastle#screens#common#drawlog(a:game.log)
	endif

	call vimcastle#screens#actions#draw(a:game.actions)
endfunction

function! s:drawsides(screen, left, right) abort
	let pad = a:screen.width - strlen(a:left) - strlen(a:right) - 2
	call append(line('$'), ' ' . a:left . repeat(' ', pad) . a:right)
endfunction

function! s:drawbars(screen, lval, lmax, rval, rmax, char) abort
	let barwidth = a:screen.width / 2 - 8
	call s:drawsides(
		\ a:screen,
		\ vimcastle#screens#common#getbar(barwidth, a:lval, a:lmax, a:char) .
		\ ' ' . a:lval,
		\ a:rval . ' ' . 
		\ vimcastle#screens#common#getbar(barwidth, a:rval, a:rmax, a:char)
		\ )
endfunction

