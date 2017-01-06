let s:state = 0

function! vimcastle#action(key) abort
	if(exists('s:state') && s:state.action(a:key))
		call vimcastle#ui#draw(s:state)
	endif
endfunction

function! vimcastle#start() abort
	let s:state = vimcastle#state#create()
	call vimcastle#ui#init()
	call vimcastle#mappings#init()
	call s:state.enter('intro')
	call vimcastle#ui#draw(s:state)

	augroup Vimcastle_ui
		autocmd!
		autocmd VimResized <buffer> call vimcastle#ui#updatescreen() | call vimcastle#ui#draw(s:state)
	augroup END
endfunction

function! vimcastle#quit() abort
	let s:state = 0
	call vimcastle#ui#quit()
endfunction
