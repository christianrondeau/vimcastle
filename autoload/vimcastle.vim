let s:state = {}

function! vimcastle#action(key) abort
	if(exists('s:state') && s:state.action(a:key))
		call vimcastle#ui#draw(s:state)
	endif
endfunction

function! vimcastle#start(dedicated) abort
	if(!has('patch-7.4.849'))
		throw 'Requires at least vim 7.4.849'
	endif
	let s:state = vimcastle#state#create()
	call vimcastle#ui#init(a:dedicated)
	call vimcastle#mappings#init()
	call s:state.enter('intro')
	call vimcastle#ui#draw(s:state)

	augroup Vimcastle_ui
		autocmd!
		autocmd VimResized <buffer> call vimcastle#ui#updatescreen() | call vimcastle#ui#draw(s:state)
	augroup END

	execute "nnoremap <buffer> q :call vimcastle#quit(" . a:dedicated . ")<CR>"
endfunction

function! vimcastle#quit(dedicated) abort
	let s:state = {}
	call vimcastle#ui#quit(a:dedicated)
endfunction
