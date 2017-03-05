function! vimcastle#state#use#enter(state) abort
	call s:refresh_menu(a:state)
endfunction

function! s:refresh_menu(state) abort
 	call a:state.actions().clear()

	if(exists('a:state.player.items') && len(a:state.player.items))
		let index = 0
		for item in a:state.player.items
			let index += 1
			if(index > 9)
				break
			endif
			call a:state.actions().add('' . index, 'Use <' . item.label . '>', function('s:action_use_' . index))
		endfor
	endif

	call a:state.actions().add('b', 'Back', function('s:action_back'))
endfunction

" Maps from 1 - 9 {{{
" NOTE: Cannot use arglist in 7.4
" call a:state.actions().add('' . index, '...', function('s:action_use', [index]))
for i in range(9)
	execute 'function! s:action_use_' . (i+1) . "(state) abort\ncall s:action_use(a:state, " . (i+1) . ")\nendfunction"
endfor
" }}}

function! s:action_use(state, index) abort
	call a:state.clearlog()
	let item = a:state.player.items[a:index - 1]

	if(!exists('item.effect'))
		throw 'Item <' . item.label . '> has no effect configured'
	endif

	call a:state.addlog('Use: <' . item.label . '>')

	let effect_value = exists('item.value') ? item.value : 0
	let result = 0
	execute 'let result = vimcastle#effects#' . item.effect . '(a:state, effect_value)'

	if(result)
		call remove(a:state.player.items, a:index - 1)
	endif

	if(exists('a:state.enemy'))
		call a:state.enter('fight')
	else
		call s:refresh_menu(a:state)
	endif
endfunction

function! s:action_back(state) abort
	if(exists('a:state.enemy'))
		call a:state.enter('fight')
	else
		call a:state.enter('inventory')
	endif
endfunction
