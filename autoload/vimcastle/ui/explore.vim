function! vimcastle#ui#explore#draw(screen, state) abort
	call vimcastle#ui#common#drawtitle(a:screen, a:state.scene.label)

	if(exists('a:state.player.health'))
		call s:drawbar(a:screen, a:state.player.health, a:state.player.getstat('health', 1))
		call append(line('$'), '')
	endif

	if(len(a:state.log))
		call vimcastle#ui#common#drawlog(a:state.log)
	endif

	call vimcastle#ui#common#drawbindings(a:state.actions())
endfunction

function! s:drawright(screen, right) abort
	let pad = a:screen.width - strlen(a:right)
	call append(line('$'), repeat(' ', pad) . a:right)
endfunction

function! s:drawbar(screen, health, maxhealth) abort
	let barwidth = a:screen.width / 2 - 8
	call s:drawright(
		\ a:screen,
		\ a:health . ' ' . 
		\ vimcastle#ui#common#getbar(barwidth, a:health, a:maxhealth, '-')
		\ )
endfunction
