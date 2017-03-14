function! vimcastle#states#use#create() abort
	let instance = {}
	let instance.enter = function('s:enter')
	let instance.action = function('s:action')
	return instance
endfunction

function! s:enter(game) abort
	call s:generate_menu(a:game)
endfunction

function! s:action(name, game) abort
	execute 'call s:action_' . a:name . '(a:game)'
endfunction

function! s:generate_menu(game) abort
	if(exists('a:game.player.items') && len(a:game.player.items))
		call a:game.addlog('Select an item to use:')
		let index = 0
		for item in a:game.player.items
			let index += 1
			if(index > 9)
				break
			endif
			call a:game.actions.add('use_' . index, '' . index, 'Use <' . item.label . '>')
		endfor
	else
		call a:game.addlog('Your inventory is empty!')
	endif

	call a:game.actions.add('back', 'b', 'Back')
endfunction

" Maps from 1 - 9 {{{
" NOTE: Cannot use arglist in 7.4
" call a:game.actions.add('' . index, '...', function('s:action_use', [index]))
for i in range(9)
	execute 'function! s:action_use_' . (i+1) . "(game) abort\ncall s:action_use(a:game, " . (i+1) . ")\nendfunction"
endfor
" }}}

function! s:action_use(game, index) abort
	let item = a:game.player.items[a:index - 1]

	if(!exists('item.effect'))
		throw 'Item <' . item.label . '> has no effect configured'
	endif

	call a:game.addlog('Use: <' . item.label . '>')

	let effect_value = exists('item.value') ? item.value : 0
	let result = 0
	execute 'let result = vimcastle#effects#' . item.effect . '(a:game, effect_value)'

	if(result)
		call remove(a:game.player.items, a:index - 1)
	endif

	if(exists('a:game.enemy'))
		call a:game.actions.add('back', 'b', 'Return to fight')
	else
		call s:generate_menu(a:game)
	endif
endfunction

function! s:action_back(game) abort
	if(exists('a:game.enemy'))
		return a:game.enter('fight')
	else
		return a:game.enter('inventory')
	endif
endfunction
