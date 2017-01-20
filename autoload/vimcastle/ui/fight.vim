function! vimcastle#ui#fight#draw(screen, state) abort
	call vimcastle#ui#common#drawtitle(a:screen, 'Fight!')
	call append(line('$'), '')

	call s:drawsides(a:screen, a:state.player.name.short,a:state.enemy.name.short)
	call s:drawbars(a:screen, a:state.player.health, a:state.enemy.health, '-')
	call append(line('$'), '')

	if(len(a:state.log))
		call vimcastle#ui#common#drawlog(a:state.log)
		call append(line('$'), '')
	endif

	call vimcastle#ui#common#drawbindings(a:state.actions)
endfunction

function! s:drawsides(screen, left, right) abort
	let pad = a:screen.width - strlen(a:left) - strlen(a:right) - 2
	call append(line('$'), ' ' . a:left . repeat(' ', pad) . a:right)
endfunction

function! s:drawbars(screen, lefthealth, righthealth, char) abort
	let barwidth = a:screen.width / 2 - 8
	call s:drawsides(
		\ a:screen,
		\ vimcastle#ui#common#getbar(barwidth, a:lefthealth.current, a:lefthealth.max, a:char) .
		\ ' ' . a:lefthealth.current,
		\ a:righthealth.current . ' ' . 
		\ vimcastle#ui#common#getbar(barwidth, a:righthealth.current, a:righthealth.max, a:char)
		\ )
endfunction
