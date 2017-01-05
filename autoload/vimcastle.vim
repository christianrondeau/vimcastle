function! vimcastle#action(key) abort
	let state = vimcastle#state#get()
	if(state.action(a:key))
		call vimcastle#ui#draw(state)
	endif
endfunction

function! vimcastle#start() abort
	let state = vimcastle#state#init()
	call vimcastle#ui#init()
	call vimcastle#mappings#init()
	call vimcastle#ui#draw(state)
endfunction

function! vimcastle#quit() abort
	let state = vimcastle#state#get()
	call state.clear()
	call vimcastle#ui#quit()
endfunction
