function! vimcastle#screens#inventory#draw(screen, game) abort
	call vimcastle#screens#common#drawtitle(a:screen, 'Inventory')

	if(exists('a:game.player.equipment.weapon'))
		let weapon = a:game.player.equipment.weapon
		call s:showitemname(weapon)
		call s:showitemdmg(weapon)
		call s:showitemstats(weapon)
	endif

	call s:showitem(a:game, 'armor')
	call s:showitem(a:game, 'ring')

	if(exists('a:game.player.items') && len(a:game.player.items))
		call append(line('$'), '* Items')
		for item in a:game.player.items
			call append(line('$'), '  * ' . item.label)
		endfor
	endif

	call append(line('$'), '')

	call vimcastle#screens#actions#draw(a:game.actions)
endfunction

function! s:showitem(game, slot) abort
	if(exists('a:game.player.equipment.' . a:slot))
		let item = a:game.player.equipment[a:slot]
		call s:showitemname(item)
		call s:showitemstats(item)
	endif
endfunction

function! s:showitemname(item) abort
	let type = substitute(a:item.slot,'\(\<\w\+\>\)', '\u\1', 'g')
	call append(line('$'), '* ' . type . ': <' . a:item.name . '>')
endfunction

function! s:showitemdmg(item) abort
	let dmg = a:item['dmg']
	let msg = '  * dmg: '
	if(dmg.min == dmg.max)
		let msg .= dmg.min
	else
		let msg .= dmg.min . '-' . dmg.max
	endif
	call append(line('$'), msg)
endfunction

function! s:showitemstats(item) abort
	for name in sort(keys(a:item.stats))
		let stat = a:item.stats[name]
		let msg = '  * ' . name . ': ' . stat
		call append(line('$'), msg)
	endfor
endfunction
