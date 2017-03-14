function! vimcastle#states#test#create() abort
	let instance = {}
	let instance.enter = function('s:enter')
	let instance.action_test_1 = function('s:action_test_1')
	return instance
endfunction

function! s:enter(game) abort
	call a:game.actions.add('test_1', '1', 'Test Action')
	call a:game.addlog('enter')
endfunction

function! s:action_test_1(game) abort
	call a:game.addlog('action_test_1')
endfunction
