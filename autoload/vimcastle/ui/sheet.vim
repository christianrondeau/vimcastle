function! vimcastle#ui#sheet#draw(screen, state) abort
	call vimcastle#ui#common#drawtitle(a:screen, 'Character Sheet')

	call append(line('$'), '* Name: ' . a:state.player.name.long)
	call append(line('$'), '* Level: ' . a:state.player.level)
	call append(line('$'), '* XP: ' . a:state.player.xp . ' (next level: ' . vimcastle#levelling#forxp(a:state.player.xp)[1] . ')')
	call append(line('$'), '* Stats:')
	call s:showhealth(a:state.player, 'Total damage you can receive before dying')
	call s:showstat(a:state.player, 'con', 'Increases your base health')
	call s:showstat(a:state.player, 'str', 'Increases base attack damage')
	call s:showstat(a:state.player, 'spd', 'Determines the first to attack in a fight')
	call s:showstat(a:state.player, 'dex', 'Determines critical damage chances')
	call append(line('$'), '')

	call vimcastle#ui#actions#draw(a:state.actions())
endfunction

function! s:showhealth(player, label) abort
	call append(line('$'), '  * health: ' . a:player.health . '/' . a:player.getmaxhealth())
	call append(line('$'), '    ' . a:label)
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
