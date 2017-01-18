function! vimcastle#ui#inventory#draw(screen, state) abort
	call vimcastle#ui#common#drawtitle(a:screen, "Inventory")
	call append(line('$'), '')

	call s:showitem('Weapon', a:state.player.equipment.weapon)
	call append(line('$'), '')

	call vimcastle#ui#common#drawbindings(a:state.nav)
endfunction

function! s:showitem(type, item)
	call append(line('$'), '* ' . a:type . ': <' . a:item.name.long . '>')
	for name in sort(keys(a:item.stats))
		let stat = a:item.stats[name]
		let msg = '  * ' . name . ': '
		if(stat.min == stat.max)
			let msg .= stat.min
		else
			let msg .= stat.min . '-' . stat.max
		endif
		call append(line('$'), msg)
	endfor
endfunction
