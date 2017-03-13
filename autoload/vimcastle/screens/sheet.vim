function! vimcastle#screens#sheet#draw(screen, game) abort
	call vimcastle#screens#common#drawtitle(a:screen, 'Character Sheet')

	call append(line('$'), '* Name: ' . a:game.player.name.long)
	call append(line('$'), '* Level: ' . a:game.player.level)
	call append(line('$'), '* XP: ' . a:game.player.xp . ' (next level: ' . vimcastle#levelling#forxp(a:game.player.xp)[1] . ')')
	call append(line('$'), '* Stats:')
	call s:showhealth(a:game.player, 'Total damage you can receive before dying')
	call s:showstat(a:game.player, 'con', 'Increases your base health')
	call s:showstat(a:game.player, 'str', 'Increases base attack damage')
	call s:showstat(a:game.player, 'spd', 'Determines the first to attack in a fight')
	call s:showstat(a:game.player, 'dex', 'Determines critical damage chances')
	call append(line('$'), '')

	call vimcastle#screens#actions#draw(a:game.actions)
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
