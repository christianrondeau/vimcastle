function! vimcastle#screens#inventory#draw(screen, game) abort
	call vimcastle#screens#common#drawtitle(a:screen, 'Inventory')

	if(exists('a:game.player.equipment.weapon'))
		let weapon = a:game.player.equipment.weapon
		call s:showitemname(weapon)
		call s:showitemdmg(weapon)
		call s:showitemstats(weapon)
	endif

	if(exists('a:game.player.equipment.armor'))
		let armor = a:game.player.equipment.armor
		call s:showitemname(armor)
		call s:showitemstats(armor)
	endif

	if(exists('a:game.player.items') && len(a:game.player.items))
		call append(line('$'), '* Items')
		for item in a:game.player.items
			call append(line('$'), '  * ' . item.label)
		endfor
	endif

	call append(line('$'), '')

	call vimcastle#screens#actions#draw(a:game.actions)
endfunction

function! s:showitemname(item) abort
	let type = substitute(a:item.slot,'\(\<\w\+\>\)', '\u\1', 'g')
	call append(line('$'), '* ' . type . ': <' . a:item.name.long . '>')
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
