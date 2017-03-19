function! vimcastle#states#use#create() abort
	let instance = {}
	let instance.cansave = 1
	let instance.enter = function('s:enter')
	let instance.action_back = function('s:action_back')
	let instance.action = function('s:action')
	return instance
endfunction

function! s:enter(game) abort
	call s:generate_menu(a:game)
endfunction

function! s:action(name, game) abort
	call s:use(a:game, str2nr(a:name[4:]))
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

function! s:use(game, index) abort
	let item = a:game.player.items[a:index - 1]

	if(!exists('item.effect'))
		throw 'Item <' . item.label . '> has no effect configured'
	endif

	call a:game.addlog('Use: <' . item.label . '>')

	let effect_value = exists('item.value') ? item.value : 0
	let effect_result = []
	execute 'let effect_result = vimcastle#effects#' . item.effect . '(a:game, effect_value)'
	call a:game.addlog(effect_result[1])

	if(effect_result[0])
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
