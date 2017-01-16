function! vimcastle#ui#inventory#draw(screen, state) abort
	call vimcastle#ui#common#drawtitle(a:screen, "Inventory")
	call append(line('$'), '')
	call append(line('$'), 'Equipment')
	call append(line('$'), '')

	call append(line('$'), '* Weapon: <' . a:state.player.weapon.name.long . '> (' . a:state.player.weapon.dmg.min . '-' . a:state.player.weapon.dmg.max . ' dmg)')
	call append(line('$'), '')

	call vimcastle#ui#common#drawbindings(a:state.nav)
endfunction
