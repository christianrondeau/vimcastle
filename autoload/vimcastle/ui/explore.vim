function! vimcastle#ui#explore#draw(screen, state) abort
	call vimcastle#ui#common#drawtitle(a:screen, "Plains")
	call append(line('$'), '')

	call s:drawbar(a:screen, a:state.player.health)
	call append(line('$'), '')

	if(exists('a:state.enemy'))
		call append(line('$'), 'You wander aimlessly when you encounter <' . a:state.enemy.name.long . '>!')
	else
		call append(line('$'), 'You wander aimlessly...')
	endif
	call append(line('$'), '')

	call vimcastle#ui#common#drawactions(a:state.actions)
endfunction

function! s:drawright(screen, right) abort
	let pad = a:screen.width - strlen(a:right)
	call append(line('$'), repeat(' ', pad) . a:right)
endfunction

function! s:drawbar(screen, health) abort
	let barwidth = a:screen.width / 2 - 8
	call s:drawright(
		\ a:screen,
		\ a:health.current . " " . 
		\ vimcastle#ui#common#getbar(barwidth, a:health.current, a:health.max, '-')
		\ )
endfunction
