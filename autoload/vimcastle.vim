function! s:initmappings() abort
	nnoremap <buffer> 1 :call vimcastle#action('1')<cr>
	nnoremap <buffer> q :bd<cr>
endfunction

function! vimcastle#action(key) abort
	call vimcastle#state#action(a:key)
	call vimcastle#ui#draw(vimcastle#state#get())
endfunction

function! vimcastle#start() abort
	call vimcastle#state#init()
	call vimcastle#ui#init()
	call vimcastle#ui#draw(vimcastle#state#get())
	call s:initmappings()
endfunction
