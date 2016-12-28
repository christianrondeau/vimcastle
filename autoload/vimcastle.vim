function! s:initmappings() abort
	let i = 0
	while(i <= 9)
		execute "nnoremap <buffer> " . i . " :call vimcastle#action('" . i . "')<cr>"
		let i += 1
	endwhile
	nnoremap <buffer> q :bd<cr>
endfunction

function! vimcastle#action(key) abort
	call vimcastle#state#action(a:key)
	call vimcastle#ui#draw(vimcastle#state#get())
endfunction

function! vimcastle#start() abort
	call vimcastle#state#init()
	call vimcastle#ui#init()
	call s:initmappings()
	call vimcastle#ui#draw(vimcastle#state#get())
endfunction
