function! vimcastle#states#test#enter(state) abort
 	call a:state.actions().clear()
	call a:state.actions().add('1', 'Test Action', function('s:action_test_1'))
	call a:state.actions().add('any', 'Test Action', function('s:action_test_any'))
endfunction

function! s:action_test_1(state) abort
	let a:state.log = ['test log 1']
endfunction

function! s:action_test_any(state) abort
	let a:state.log = ['test log any']
endfunction

