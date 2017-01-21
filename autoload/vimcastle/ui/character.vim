function! vimcastle#ui#character#draw(screen, state) abort
	call vimcastle#ui#common#drawtitle(a:screen, 'Character')
	call append(line('$'), '')

	call append(line('$'), '* Name: ' . a:state.player.name.long)
	call append(line('$'), '* Health: ' . a:state.player.health.current . '/' . a:state.player.health.max)
	call append(line('$'), '* Stats:')
	call s:showstat(a:state.player, 'str', 'Increases base attack damage')
	call s:showstat(a:state.player, 'spd', 'Determines the first to attack in a fight')
	call s:showstat(a:state.player, 'dex', 'Determines critical damage chances')
	call append(line('$'), '')

	call vimcastle#ui#common#drawbindings(a:state.nav)
endfunction

function! s:showstat(player, stat, label) abort
	let base = a:player.getstat(a:stat, 0)
	let bonus = a:player.getstat(a:stat, 1) - base
	let msg = base
	if(bonus > 0)
		let msg .= ' [+' . bonus . ']'
	endif
	call append(line('$'), '  * ' . a:stat . ': ' . msg)
	call append(line('$'), '    ' . a:label)
endfunction
