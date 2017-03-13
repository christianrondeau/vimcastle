function! vimcastle#screens#explore#draw(screen, game) abort
	call vimcastle#screens#common#drawtitle(a:screen, a:game.scene.info.label)

	if(exists('a:game.player.health'))
		call s:drawbar(a:screen, a:game.player.health, a:game.player.getmaxhealth())
		call append(line('$'), '')
	endif

	if(len(a:game.log))
		call vimcastle#screens#common#drawlog(a:game.log)
	endif

	call vimcastle#screens#actions#draw(a:game.actions)
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
		\ vimcastle#screens#common#getbar(barwidth, a:health, a:maxhealth, '-')
		\ )
endfunction

