function! vimcastle#ui#inventory#draw(screen, state) abort
	call vimcastle#ui#common#drawtitle(a:screen, 'Inventory')
	call append(line('$'), '')

	if(exists('a:state.player.equipment.weapon'))
		let weapon = a:state.player.equipment.weapon
		call s:showitemname('Weapon', weapon)
		call s:showitemdmg(weapon)
		call s:showitemstats(weapon)
	endif
	if(exists('a:state.player.equipment.armor'))
		let armor = a:state.player.equipment.armor
		call s:showitemname('Armor', armor)
		call s:showitemstats(armor)
	endif
	call append(line('$'), '')

	call vimcastle#ui#common#drawbindings(a:state.nav)
endfunction

function! s:showitemname(type, item) abort
	call append(line('$'), '* ' . a:type . ': <' . a:item.name.long . '>')
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
